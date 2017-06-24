/*

 Copyright (c) 2014 University of Edinburgh, Imperial College, University of Manchester.
 Developed in the PAMELA project, EPSRC Programme Grant EP/K008730/1

 This code is licensed under the MIT License.

 */
#include <kernels.h>



#include "common_opencl.h"


#include <TooN/TooN.h>
#include <TooN/se3.h>
#include <TooN/GR_SVD.h>

#ifdef __APPLE__
#include <mach/clock.h>
#include <mach/mach.h>







//////////////////////////////////////////////

#include <stdlib.h>
#include <sys/types.h>
#include <dlfcn.h>
#include <iostream>
#include <fstream>
#include <sstream>
#include <stdexcept>
#include <vector>

#include "CL/opencl.h"



///////////////////////////////////////////////

	

	
	#define TICK()    {if (print_kernel_timing) {\
		host_get_clock_service(mach_host_self(), SYSTEM_CLOCK, &cclock);\
		clock_get_time(cclock, &tick_clockData);\
		mach_port_deallocate(mach_task_self(), cclock);\
		}}

	#define TOCK(str,size)  {if (print_kernel_timing) {\
		host_get_clock_service(mach_host_self(), SYSTEM_CLOCK, &cclock);\
		clock_get_time(cclock, &tock_clockData);\
		mach_port_deallocate(mach_task_self(), cclock);\
		std::cerr<< str << " ";\
		if((tock_clockData.tv_sec > tick_clockData.tv_sec) && (tock_clockData.tv_nsec >= tick_clockData.tv_nsec))   std::cerr<< tock_clockData.tv_sec - tick_clockData.tv_sec << std::setfill('0') << std::setw(9);\
		std::cerr  << (( tock_clockData.tv_nsec - tick_clockData.tv_nsec) + ((tock_clockData.tv_nsec<tick_clockData.tv_nsec)?1000000000:0)) << " " <<  size << std::endl;}}
#else
	
	#define TICK()    {if (print_kernel_timing) {clock_gettime(CLOCK_MONOTONIC, &tick_clockData);}}

	#define TOCK(str,size)  {if (print_kernel_timing) {clock_gettime(CLOCK_MONOTONIC, &tock_clockData); std::cerr<< str << " ";\
		if((tock_clockData.tv_sec > tick_clockData.tv_sec) && (tock_clockData.tv_nsec >= tick_clockData.tv_nsec))   std::cerr<< tock_clockData.tv_sec - tick_clockData.tv_sec << std::setfill('0') << std::setw(9);\
		std::cerr  << (( tock_clockData.tv_nsec - tick_clockData.tv_nsec) + ((tock_clockData.tv_nsec<tick_clockData.tv_nsec)?1000000000:0)) << " " <<  size << std::endl;}}

#endif

// input once
float * gaussian;

// inter-frame
Volume volume;
float3 * vertex;
float3 * normal;

// intra-frame
TrackData * trackingResult;
float* reductionoutput;
float ** ScaledDepth;

float * floatDepth;


Matrix4 oldPose;
Matrix4 raycastPose;
float3 ** inputVertex;
float3 ** inputNormal;



//need to add these for the new kernel
uint2 computationSizeBkp = make_uint2(0, 0);

cl_mem ocl_depth_buffer = NULL;
cl_mem ocl_FloatDepth = NULL;

cl_mem * ocl_ScaledDepth = NULL;
cl_mem ocl_gaussian = NULL;
size_t gaussianS;

cl_mem * ocl_inputVertex = NULL;

cl_mem * ocl_inputNormal = NULL;

cl_mem ocl_normal = NULL;
cl_mem ocl_vertex = NULL;
cl_mem ocl_trackingResult = NULL;



cl_mem ocl_reduce_output_buffer = NULL;
//float * reduceOutputBuffer = NULL;
// reduction parameters
static const size_t size_of_group = 64;
static const size_t number_of_groups = 8;

cl_mem ocl_volume_data = NULL;


cl_kernel mm2meters_ocl_kernel;
cl_kernel bilateralFilter_ocl_kernel;

int bool_frame=0;
/////////

///////////////////////////////////////////  timing

void  checkError(cl_int err,std::string str) {

	if (err != CL_SUCCESS)  {
	std::cout << str << std::endl; exit(err);
	}
}

unsigned long int computeEventDuration(cl_event* event) {
	if (event == NULL)
		throw std::runtime_error(
				"Error computing event duration. \
                              Event is not initialized");
	cl_int errorCode;
	cl_ulong start, end;
	errorCode = clGetEventProfilingInfo(*event, CL_PROFILING_COMMAND_START,
			sizeof(cl_ulong), &start, NULL);
	checkError(errorCode, "Error querying the event start time");
	errorCode = clGetEventProfilingInfo(*event, CL_PROFILING_COMMAND_END,
			sizeof(cl_ulong), &end, NULL);
	checkError(errorCode, "Error querying the event end time");
	return static_cast<unsigned long>(end - start);
}



cl_event write_event[10];
cl_event kernel_event[10];
cl_event finish_event[10];


//////////////////////////////////////////

bool print_kernel_timing = false;
#ifdef __APPLE__
	clock_serv_t cclock;
	mach_timespec_t tick_clockData;
	mach_timespec_t tock_clockData;
#else
	struct timespec tick_clockData;
	struct timespec tock_clockData;
#endif
	
void Kfusion::languageSpecificConstructor() {


	init();
 
  const char * kernel_name = "AOCraycastKernel";  // Kernel name, as defined in the CL file
  kernel = clCreateKernel(program, kernel_name, &clError);
  checkErr(clError, "Failed to create kernel");

	if (getenv("KERNEL_TIMINGS"))
		print_kernel_timing = true;

	// internal buffers to initialize
	reductionoutput = (float*) calloc(sizeof(float) * 8 * 32, 1);

	ScaledDepth = (float**) calloc(sizeof(float*) * iterations.size(), 1);
 	//ScaledDepth = (float **)alignedMalloc(sizeof(float*) * iterations.size());
   
	inputVertex = (float3**) calloc(sizeof(float3*) * iterations.size(), 1);
	//inputVertex = (float3 **)alignedMalloc(sizeof(float3*) * iterations.size());
 
	inputNormal = (float3**) calloc(sizeof(float3*) * iterations.size(), 1);



////////////////////
	ocl_FloatDepth = clCreateBuffer(context, CL_MEM_READ_WRITE,
			sizeof(float) * computationSize.x * computationSize.y, NULL,
			&clError);
	checkErr(clError, "clCreateBuffer");

	//ocl scaled_depth decleration
	ocl_ScaledDepth = (cl_mem*) malloc(sizeof(cl_mem) * iterations.size());
  
  
  	
	//ocl_inputVertex decleration
	ocl_inputVertex = (cl_mem*) malloc(sizeof(cl_mem) * iterations.size());
    
  //ocl input normal decleration  
	ocl_inputNormal = (cl_mem*) malloc(sizeof(cl_mem) * iterations.size());
 
 
 
	ocl_normal = clCreateBuffer(context, CL_MEM_READ_WRITE,
			sizeof(float3) * computationSize.x * computationSize.y, NULL,
			&clError);
		checkErr(clError, "clCreateBuffer");
   
   	ocl_vertex = clCreateBuffer(context, CL_MEM_READ_WRITE,
			sizeof(float3) * computationSize.x * computationSize.y, NULL,
			&clError);
		checkErr(clError, "clCreateBuffer");

	ocl_trackingResult = clCreateBuffer(context, CL_MEM_READ_WRITE,
			sizeof(TrackData) * computationSize.x * computationSize.y, NULL,
			&clError);
		checkErr(clError, "clCreateBuffer");
   
   
   	ocl_reduce_output_buffer = clCreateBuffer(context, CL_MEM_WRITE_ONLY,
			32 * number_of_groups * sizeof(float), NULL, &clError);
		checkErr(clError, "clCreateBuffer");
   //reduceOutputBuffer = (float*) malloc(number_of_groups * 32 * sizeof(float));
   
   
   	//ocl_volume_data
	ocl_volume_data = clCreateBuffer(context, CL_MEM_READ_WRITE,
			sizeof(short2) * volumeResolution.x * volumeResolution.y
					* volumeResolution.z,
			NULL, &clError);
	checkErr(clError, "clCreateBuffer");
//////////////////////



	for (unsigned int i = 0; i < iterations.size(); ++i) {
 
 //ocl scaled depth
 	  ocl_ScaledDepth[i] = clCreateBuffer(context, CL_MEM_READ_WRITE,
				sizeof(float) * (computationSize.x * computationSize.y)
					/ (int) pow(2, i), NULL, &clError);
		checkErr(clError, "clCreateBuffer");
   
		//ScaledDepth[i] = (float*) calloc(
		//		sizeof(float) * (computationSize.x * computationSize.y)
		//				/ (int) pow(2, i), 1);
   	ScaledDepth[i]= (float *)alignedMalloc(				sizeof(float) * (computationSize.x * computationSize.y) / (int) pow(2, i));
                    
                    
 //ocl input vertex decleration                                                           
		ocl_inputVertex[i] = clCreateBuffer(context, CL_MEM_READ_WRITE,
			sizeof(float3) * (computationSize.x * computationSize.y)
					/ (int) pow(2, i), NULL, &clError);
     checkErr(clError, "clCreateBuffer");
                
//ocl input normal decleration                
    ocl_inputNormal[i] = clCreateBuffer(context, CL_MEM_READ_WRITE,
    sizeof(float3) * (computationSize.x * computationSize.y)
    / (int) pow(2, i), NULL, &clError);
    checkErr(clError, "clCreateBuffer");
                                                                                                    
		//inputVertex[i] = (float3*) calloc(
		//		sizeof(float3) * (computationSize.x * computationSize.y)
		//				/ (int) pow(2, i), 1);
                    
   	inputVertex[i]= (float3 *)alignedMalloc(				sizeof(float3) * (computationSize.x * computationSize.y) / (int) pow(2, i));                
                    
		//inputNormal[i] = (float3*) calloc(
		//		sizeof(float3) * (computationSize.x * computationSize.y)
		//				/ (int) pow(2, i), 1);
                    
 	  inputNormal[i]= (float3 *)alignedMalloc(				sizeof(float3) * (computationSize.x * computationSize.y) / (int) pow(2, i));    
	}




///////////////////////


	//float depth decleration alligend
	floatDepth = (float *)alignedMalloc(computationSize.x * computationSize.y * sizeof(float));



//////////////////////



	vertex = (float3*) calloc(
			sizeof(float3) * computationSize.x * computationSize.y, 1);
	normal = (float3*) calloc(
			sizeof(float3) * computationSize.x * computationSize.y, 1);
	trackingResult = (TrackData*) calloc(
			sizeof(TrackData) * computationSize.x * computationSize.y, 1);

	// ********* BEGIN : Generate the gaussian *************
	gaussianS = radius * 2 + 1;
	gaussian = (float*) calloc(gaussianS * sizeof(float), 1);
 	//gaussian = (float *)alignedMalloc(gaussianS * sizeof(float));
  
        
	int x;
	for (unsigned int i = 0; i < gaussianS; i++) {
		x = i - 2;
		gaussian[i] = expf(-(x * x) / (2 * delta * delta));
	}
 
 	//ocl_gausian decleration
	ocl_gaussian = clCreateBuffer(context, CL_MEM_READ_ONLY,
			gaussianS * sizeof(float), NULL, &clError);
		checkErr(clError, "clCreateBuffer");
	// ********* END : Generate the gaussian *************

	volume.init(volumeResolution, volumeDimensions);
	reset();



}

Kfusion::~Kfusion() {

	
/////////////////////////////////////////////////////////////////
	free(floatDepth);

	//could be used instead but with malloc allocation in constructor
	//if (floatDepth)
	//	free(floatDepth);
	//floatDepth = NULL;
/////////////////////////////////////////////////////////////////
	free(trackingResult);

	free(reductionoutput);
	for (unsigned int i = 0; i < iterations.size(); ++i) {
 
 		if (ocl_ScaledDepth[i]) {
		clError = clReleaseMemObject(ocl_ScaledDepth[i]);
		checkErr(clError, "clReleaseMem");
		ocl_ScaledDepth[i] = NULL;
		}

	  if (ocl_inputVertex[i]) {
	    clError = clReleaseMemObject(ocl_inputVertex[i]);
	    checkErr(clError, "clReleaseMem");
	    ocl_inputVertex[i] = NULL;
	  }

 	  if (ocl_inputNormal[i]) {
	    clError = clReleaseMemObject(ocl_inputNormal[i]);
	    checkErr(clError, "clReleaseMem");
		ocl_inputNormal[i] = NULL;
	  }
     
		free(ScaledDepth[i]);
		free(inputVertex[i]);
		free(inputNormal[i]);
	}
 
 
 	if (ocl_ScaledDepth) {
		free(ocl_ScaledDepth);
	ocl_ScaledDepth = NULL;
	}
 
 
	if (ocl_inputVertex) {
		free(ocl_inputVertex);
	ocl_inputVertex = NULL;
	}
 
 	if (ocl_inputNormal) {
		free(ocl_inputNormal);
	ocl_inputNormal = NULL;
	}
 
 	if (ocl_normal) {
  clError = clReleaseMemObject(ocl_normal);
  checkErr(clError, "clReleaseMem");
  ocl_normal = NULL;
	}
 	if (ocl_vertex) {
	 clError = 	clReleaseMemObject(ocl_vertex);
		checkErr(clError, "clReleaseMem");
	ocl_vertex = NULL;
	}
 
 	if (ocl_trackingResult) {
	 clError = 	clReleaseMemObject(ocl_trackingResult);
		checkErr(clError, "clReleaseMem");
	ocl_trackingResult = NULL;
	}
 
 	if (ocl_reduce_output_buffer) {
	 clError = 	clReleaseMemObject(ocl_reduce_output_buffer);
		checkErr(clError, "clReleaseMem");
	ocl_reduce_output_buffer = NULL;
	}
 	//if (reduceOutputBuffer)
	//	free(reduceOutputBuffer);
	//reduceOutputBuffer = NULL;
 
 	if (ocl_volume_data) {
	 clError = 	clReleaseMemObject(ocl_volume_data);
		checkErr(clError, "clReleaseMem");
	ocl_volume_data = NULL;
	}
 
 
	free(ScaledDepth);
	free(inputVertex);
	free(inputNormal);

	free(vertex);
	free(normal);
	free(gaussian);

	volume.release();




///////need to add these for the new kernel
	if (ocl_FloatDepth)
		clReleaseMemObject(ocl_FloatDepth);
	ocl_FloatDepth = NULL;


	if (ocl_depth_buffer)
		clReleaseMemObject(ocl_depth_buffer);
	ocl_depth_buffer = NULL;

	RELEASE_KERNEL(kernel);
	computationSizeBkp = make_uint2(0, 0);
	clean();
///////////////////

}
void Kfusion::reset() {
	initVolumeKernel(volume);
}
void init() {
/////////////
opencl_init();
/////////////

}
;
// stub
void clean() {
///////////
	opencl_clean();
////////////
}
;
// stub

void initVolumeKernel(Volume volume) {
	TICK();
	for (unsigned int x = 0; x < volume.size.x; x++)
		for (unsigned int y = 0; y < volume.size.y; y++) {
			for (unsigned int z = 0; z < volume.size.z; z++) {
				//std::cout <<  x << " " << y << " " << z <<"\n";
				volume.setints(x, y, z, make_float2(1.0f, 0.0f));
			}
		}
	TOCK("initVolumeKernel", volume.size.x * volume.size.y * volume.size.z);
}

void bilateralFilterKernel(float* out, const float* in, uint2 size,
		const float * gaussian, float e_d, int r) {
	TICK()
		uint y;
		float e_d_squared_2 = e_d * e_d * 2;
#pragma omp parallel for \
	    shared(out),private(y)   
		for (y = 0; y < size.y; y++) {
			for (uint x = 0; x < size.x; x++) {
				uint pos = x + y * size.x;
				if (in[pos] == 0) {
					out[pos] = 0;
					continue;
				}

				float sum = 0.0f;
				float t = 0.0f;

				const float center = in[pos];

				for (int i = -r; i <= r; ++i) {
					for (int j = -r; j <= r; ++j) {
						uint2 curPos = make_uint2(clamp(x + i, 0u, size.x - 1),
								clamp(y + j, 0u, size.y - 1));
						const float curPix = in[curPos.x + curPos.y * size.x];
						if (curPix > 0) {
							const float mod = sq(curPix - center);
							const float factor = gaussian[i + r]
									* gaussian[j + r]
									* expf(-mod / e_d_squared_2);
							t += factor * curPix;
							sum += factor;
						}
					}
				}
				out[pos] = t / sum;
			}
		}
		TOCK("bilateralFilterKernel", size.x * size.y);
}

void depth2vertexKernel(float3* vertex, const float * depth, uint2 imageSize,
		const Matrix4 invK) {
	TICK();
	unsigned int x, y;
#pragma omp parallel for \
         shared(vertex), private(x, y)
	for (y = 0; y < imageSize.y; y++) {
		for (x = 0; x < imageSize.x; x++) {

			if (depth[x + y * imageSize.x] > 0) {
				vertex[x + y * imageSize.x] = depth[x + y * imageSize.x]
						* (rotate(invK, make_float3(x, y, 1.f)));
			} else {
				vertex[x + y * imageSize.x] = make_float3(0);
			}
		}
	}
	TOCK("depth2vertexKernel", imageSize.x * imageSize.y);
}

void vertex2normalKernel(float3 * out, const float3 * in, uint2 imageSize) {
	TICK();
	unsigned int x, y;
#pragma omp parallel for \
        shared(out), private(x,y)
	for (y = 0; y < imageSize.y; y++) {
		for (x = 0; x < imageSize.x; x++) {
			const uint2 pleft = make_uint2(max(int(x) - 1, 0), y);
			const uint2 pright = make_uint2(min(x + 1, (int) imageSize.x - 1),
					y);
			const uint2 pup = make_uint2(x, max(int(y) - 1, 0));
			const uint2 pdown = make_uint2(x,
					min(y + 1, ((int) imageSize.y) - 1));

			const float3 left = in[pleft.x + imageSize.x * pleft.y];
			const float3 right = in[pright.x + imageSize.x * pright.y];
			const float3 up = in[pup.x + imageSize.x * pup.y];
			const float3 down = in[pdown.x + imageSize.x * pdown.y];

			if (left.z == 0 || right.z == 0 || up.z == 0 || down.z == 0) {
				out[x + y * imageSize.x].x = KFUSION_INVALID;
				continue;
			}
			const float3 dxv = right - left;
			const float3 dyv = down - up;
			out[x + y * imageSize.x] = normalize(cross(dyv, dxv)); // switched dx and dy to get factor -1
		}
	}
	TOCK("vertex2normalKernel", imageSize.x * imageSize.y);
}

void new_reduce(int blockIndex, float * out, TrackData* J, const uint2 Jsize,
		const uint2 size) {
	float *sums = out + blockIndex * 32;

	float * jtj = sums + 7;
	float * info = sums + 28;
	for (uint i = 0; i < 32; ++i)
		sums[i] = 0;
	float sums0, sums1, sums2, sums3, sums4, sums5, sums6, sums7, sums8, sums9,
			sums10, sums11, sums12, sums13, sums14, sums15, sums16, sums17,
			sums18, sums19, sums20, sums21, sums22, sums23, sums24, sums25,
			sums26, sums27, sums28, sums29, sums30, sums31;
	sums0 = 0.0f;
	sums1 = 0.0f;
	sums2 = 0.0f;
	sums3 = 0.0f;
	sums4 = 0.0f;
	sums5 = 0.0f;
	sums6 = 0.0f;
	sums7 = 0.0f;
	sums8 = 0.0f;
	sums9 = 0.0f;
	sums10 = 0.0f;
	sums11 = 0.0f;
	sums12 = 0.0f;
	sums13 = 0.0f;
	sums14 = 0.0f;
	sums15 = 0.0f;
	sums16 = 0.0f;
	sums17 = 0.0f;
	sums18 = 0.0f;
	sums19 = 0.0f;
	sums20 = 0.0f;
	sums21 = 0.0f;
	sums22 = 0.0f;
	sums23 = 0.0f;
	sums24 = 0.0f;
	sums25 = 0.0f;
	sums26 = 0.0f;
	sums27 = 0.0f;
	sums28 = 0.0f;
	sums29 = 0.0f;
	sums30 = 0.0f;
	sums31 = 0.0f;
// comment me out to try coarse grain parallelism 
#pragma omp parallel for reduction(+:sums0,sums1,sums2,sums3,sums4,sums5,sums6,sums7,sums8,sums9,sums10,sums11,sums12,sums13,sums14,sums15,sums16,sums17,sums18,sums19,sums20,sums21,sums22,sums23,sums24,sums25,sums26,sums27,sums28,sums29,sums30,sums31)
	for (uint y = blockIndex; y < size.y; y += 8) {
		for (uint x = 0; x < size.x; x++) {

			const TrackData & row = J[(x + y * Jsize.x)]; // ...
			if (row.result < 1) {
				// accesses sums[28..31]
				/*(sums+28)[1]*/sums29 += row.result == -4 ? 1 : 0;
				/*(sums+28)[2]*/sums30 += row.result == -5 ? 1 : 0;
				/*(sums+28)[3]*/sums31 += row.result > -4 ? 1 : 0;

				continue;
			}
			// Error part
			/*sums[0]*/sums0 += row.error * row.error;

			// JTe part
			/*for(int i = 0; i < 6; ++i)
			 sums[i+1] += row.error * row.J[i];*/
			sums1 += row.error * row.J[0];
			sums2 += row.error * row.J[1];
			sums3 += row.error * row.J[2];
			sums4 += row.error * row.J[3];
			sums5 += row.error * row.J[4];
			sums6 += row.error * row.J[5];

			// JTJ part, unfortunatly the double loop is not unrolled well...
			/*(sums+7)[0]*/sums7 += row.J[0] * row.J[0];
			/*(sums+7)[1]*/sums8 += row.J[0] * row.J[1];
			/*(sums+7)[2]*/sums9 += row.J[0] * row.J[2];
			/*(sums+7)[3]*/sums10 += row.J[0] * row.J[3];

			/*(sums+7)[4]*/sums11 += row.J[0] * row.J[4];
			/*(sums+7)[5]*/sums12 += row.J[0] * row.J[5];

			/*(sums+7)[6]*/sums13 += row.J[1] * row.J[1];
			/*(sums+7)[7]*/sums14 += row.J[1] * row.J[2];
			/*(sums+7)[8]*/sums15 += row.J[1] * row.J[3];
			/*(sums+7)[9]*/sums16 += row.J[1] * row.J[4];

			/*(sums+7)[10]*/sums17 += row.J[1] * row.J[5];

			/*(sums+7)[11]*/sums18 += row.J[2] * row.J[2];
			/*(sums+7)[12]*/sums19 += row.J[2] * row.J[3];
			/*(sums+7)[13]*/sums20 += row.J[2] * row.J[4];
			/*(sums+7)[14]*/sums21 += row.J[2] * row.J[5];

			/*(sums+7)[15]*/sums22 += row.J[3] * row.J[3];
			/*(sums+7)[16]*/sums23 += row.J[3] * row.J[4];
			/*(sums+7)[17]*/sums24 += row.J[3] * row.J[5];

			/*(sums+7)[18]*/sums25 += row.J[4] * row.J[4];
			/*(sums+7)[19]*/sums26 += row.J[4] * row.J[5];

			/*(sums+7)[20]*/sums27 += row.J[5] * row.J[5];

			// extra info here
			/*(sums+28)[0]*/sums28 += 1;

		}
	}
	sums[0] = sums0;
	sums[1] = sums1;
	sums[2] = sums2;
	sums[3] = sums3;
	sums[4] = sums4;
	sums[5] = sums5;
	sums[6] = sums6;
	sums[7] = sums7;
	sums[8] = sums8;
	sums[9] = sums9;
	sums[10] = sums10;
	sums[11] = sums11;
	sums[12] = sums12;
	sums[13] = sums13;
	sums[14] = sums14;
	sums[15] = sums15;
	sums[16] = sums16;
	sums[17] = sums17;
	sums[18] = sums18;
	sums[19] = sums19;
	sums[20] = sums20;
	sums[21] = sums21;
	sums[22] = sums22;
	sums[23] = sums23;
	sums[24] = sums24;
	sums[25] = sums25;
	sums[26] = sums26;
	sums[27] = sums27;
	sums[28] = sums28;
	sums[29] = sums29;
	sums[30] = sums30;
	sums[31] = sums31;

}
void reduceKernel(float * out, TrackData* J, const uint2 Jsize,
		const uint2 size) {
	TICK();
	int blockIndex;
#ifdef OLDREDUCE
#pragma omp parallel for private (blockIndex)
#endif
	for (blockIndex = 0; blockIndex < 8; blockIndex++) {

#ifdef OLDREDUCE
		float S[112][32]; // this is for the final accumulation
		// we have 112 threads in a blockdim
		// and 8 blocks in a gridDim?
		// ie it was launched as <<<8,112>>>
		uint sline;// threadIndex.x
		float sums[32];

		for(int threadIndex = 0; threadIndex < 112; threadIndex++) {
			sline = threadIndex;
			float * jtj = sums+7;
			float * info = sums+28;
			for(uint i = 0; i < 32; ++i) sums[i] = 0;

			for(uint y = blockIndex; y < size.y; y += 8 /*gridDim.x*/) {
				for(uint x = sline; x < size.x; x += 112 /*blockDim.x*/) {
					const TrackData & row = J[(x + y * Jsize.x)]; // ...

					if(row.result < 1) {
						// accesses S[threadIndex][28..31]
						info[1] += row.result == -4 ? 1 : 0;
						info[2] += row.result == -5 ? 1 : 0;
						info[3] += row.result > -4 ? 1 : 0;
						continue;
					}
					// Error part
					sums[0] += row.error * row.error;

					// JTe part
					for(int i = 0; i < 6; ++i)
					sums[i+1] += row.error * row.J[i];

					// JTJ part, unfortunatly the double loop is not unrolled well...
					jtj[0] += row.J[0] * row.J[0];
					jtj[1] += row.J[0] * row.J[1];
					jtj[2] += row.J[0] * row.J[2];
					jtj[3] += row.J[0] * row.J[3];

					jtj[4] += row.J[0] * row.J[4];
					jtj[5] += row.J[0] * row.J[5];

					jtj[6] += row.J[1] * row.J[1];
					jtj[7] += row.J[1] * row.J[2];
					jtj[8] += row.J[1] * row.J[3];
					jtj[9] += row.J[1] * row.J[4];

					jtj[10] += row.J[1] * row.J[5];

					jtj[11] += row.J[2] * row.J[2];
					jtj[12] += row.J[2] * row.J[3];
					jtj[13] += row.J[2] * row.J[4];
					jtj[14] += row.J[2] * row.J[5];

					jtj[15] += row.J[3] * row.J[3];
					jtj[16] += row.J[3] * row.J[4];
					jtj[17] += row.J[3] * row.J[5];

					jtj[18] += row.J[4] * row.J[4];
					jtj[19] += row.J[4] * row.J[5];

					jtj[20] += row.J[5] * row.J[5];

					// extra info here
					info[0] += 1;
				}
			}

			for(int i = 0; i < 32; ++i) { // copy over to shared memory
				S[sline][i] = sums[i];
			}
			// WE NO LONGER NEED TO DO THIS AS the threads execute sequentially inside a for loop

		} // threads now execute as a for loop.
		  //so the __syncthreads() is irrelevant

		for(int ssline = 0; ssline < 32; ssline++) { // sum up columns and copy to global memory in the final 32 threads
			for(unsigned i = 1; i < 112 /*blockDim.x*/; ++i) {
				S[0][ssline] += S[i][ssline];
			}
			out[ssline+blockIndex*32] = S[0][ssline];
		}
#else 
		new_reduce(blockIndex, out, J, Jsize, size);
#endif

	}

	TooN::Matrix<8, 32, float, TooN::Reference::RowMajor> values(out);
	for (int j = 1; j < 8; ++j) {
		values[0] += values[j];
		//std::cerr << "REDUCE ";for(int ii = 0; ii < 32;ii++)
		//std::cerr << values[0][ii] << " ";
		//std::cerr << "\n";
	}
	TOCK("reduceKernel", 512);
}

void trackKernel(TrackData* output, const float3* inVertex,
		const float3* inNormal, uint2 inSize, const float3* refVertex,
		const float3* refNormal, uint2 refSize, const Matrix4 Ttrack,
		const Matrix4 view, const float dist_threshold,
		const float normal_threshold) {
	TICK();
	uint2 pixel = make_uint2(0, 0);
	unsigned int pixely, pixelx;
#pragma omp parallel for \
	    shared(output), private(pixel,pixelx,pixely)
	for (pixely = 0; pixely < inSize.y; pixely++) {
		for (pixelx = 0; pixelx < inSize.x; pixelx++) {
			pixel.x = pixelx;
			pixel.y = pixely;

			TrackData & row = output[pixel.x + pixel.y * refSize.x];

			if (inNormal[pixel.x + pixel.y * inSize.x].x == KFUSION_INVALID) {
				row.result = -1;
				continue;
			}

			const float3 projectedVertex = Ttrack
					* inVertex[pixel.x + pixel.y * inSize.x];
			const float3 projectedPos = view * projectedVertex;
			const float2 projPixel = make_float2(
					projectedPos.x / projectedPos.z + 0.5f,
					projectedPos.y / projectedPos.z + 0.5f);
			if (projPixel.x < 0 || projPixel.x > refSize.x - 1
					|| projPixel.y < 0 || projPixel.y > refSize.y - 1) {
				row.result = -2;
				continue;
			}

			const uint2 refPixel = make_uint2(projPixel.x, projPixel.y);
			const float3 referenceNormal = refNormal[refPixel.x
					+ refPixel.y * refSize.x];

			if (referenceNormal.x == KFUSION_INVALID) {
				row.result = -3;
				continue;
			}

			const float3 diff = refVertex[refPixel.x + refPixel.y * refSize.x]
					- projectedVertex;
			const float3 projectedNormal = rotate(Ttrack,
					inNormal[pixel.x + pixel.y * inSize.x]);

			if (length(diff) > dist_threshold) {
				row.result = -4;
				continue;
			}
			if (dot(projectedNormal, referenceNormal) < normal_threshold) {
				row.result = -5;
				continue;
			}
			row.result = 1;
			row.error = dot(referenceNormal, diff);
			((float3 *) row.J)[0] = referenceNormal;
			((float3 *) row.J)[1] = cross(projectedVertex, referenceNormal);
		}
	}
	TOCK("trackKernel", inSize.x * inSize.y);
}

void mm2metersKernel(float * out, uint2 outSize, const ushort * in,
		uint2 inSize) {
	TICK();
	// Check for unsupported conditions
	if ((inSize.x < outSize.x) || (inSize.y < outSize.y)) {
		std::cerr << "Invalid ratio." << std::endl;
		exit(1);
	}
	if ((inSize.x % outSize.x != 0) || (inSize.y % outSize.y != 0)) {
		std::cerr << "Invalid ratio." << std::endl;
		exit(1);
	}
	if ((inSize.x / outSize.x != inSize.y / outSize.y)) {
		std::cerr << "Invalid ratio." << std::endl;
		exit(1);
	}

	int ratio = inSize.x / outSize.x;
	unsigned int y;
#pragma omp parallel for \
        shared(out), private(y)
	for (y = 0; y < outSize.y; y++)
		for (unsigned int x = 0; x < outSize.x; x++) {
			out[x + outSize.x * y] = in[x * ratio + inSize.x * y * ratio]
					/ 1000.0f;
		}
	TOCK("mm2metersKernel", outSize.x * outSize.y);
}

void halfSampleRobustImageKernel(float* out, const float* in, uint2 inSize,
		const float e_d, const int r) {
	TICK();
	uint2 outSize = make_uint2(inSize.x / 2, inSize.y / 2);
	unsigned int y;
#pragma omp parallel for \
        shared(out), private(y)
	for (y = 0; y < outSize.y; y++) {
		for (unsigned int x = 0; x < outSize.x; x++) {
			uint2 pixel = make_uint2(x, y);
			const uint2 centerPixel = 2 * pixel;

			float sum = 0.0f;
			float t = 0.0f;
			const float center = in[centerPixel.x
					+ centerPixel.y * inSize.x];
			for (int i = -r + 1; i <= r; ++i) {
				for (int j = -r + 1; j <= r; ++j) {
					uint2 cur = make_uint2(
							clamp(
									make_int2(centerPixel.x + j,
											centerPixel.y + i), make_int2(0),
									make_int2(2 * outSize.x - 1,
											2 * outSize.y - 1)));
					float current = in[cur.x + cur.y * inSize.x];
					if (fabsf(current - center) < e_d) {
						sum += 1.0f;
						t += current;
					}
				}
			}
			out[pixel.x + pixel.y * outSize.x] = t / sum;
		}
	}
	TOCK("halfSampleRobustImageKernel", outSize.x * outSize.y);
}

void integrateKernel(Volume vol, const float* depth, uint2 depthSize,
		const Matrix4 invTrack, const Matrix4 K, const float mu,
		const float maxweight) {
	TICK();
	const float3 delta = rotate(invTrack,
			make_float3(0, 0, vol.dim.z / vol.size.z));
	const float3 cameraDelta = rotate(K, delta);
	unsigned int y;
#pragma omp parallel for \
        shared(vol), private(y)
	for (y = 0; y < vol.size.y; y++)
		for (unsigned int x = 0; x < vol.size.x; x++) {

			uint3 pix = make_uint3(x, y, 0); //pix.x = x;pix.y = y;
			float3 pos = invTrack * vol.pos(pix);
			float3 cameraX = K * pos;

			for (pix.z = 0; pix.z < vol.size.z;
					++pix.z, pos += delta, cameraX += cameraDelta) {
				if (pos.z < 0.0001f) // some near plane constraint
					continue;
				const float2 pixel = make_float2(cameraX.x / cameraX.z + 0.5f,
						cameraX.y / cameraX.z + 0.5f);
				if (pixel.x < 0 || pixel.x > depthSize.x - 1 || pixel.y < 0
						|| pixel.y > depthSize.y - 1)
					continue;
				const uint2 px = make_uint2(pixel.x, pixel.y);
				if (depth[px.x + px.y * depthSize.x] == 0)
					continue;
				const float diff =
						(depth[px.x + px.y * depthSize.x] - cameraX.z)
								* std::sqrt(
										1 + sq(pos.x / pos.z)
												+ sq(pos.y / pos.z));
				if (diff > -mu) {
					const float sdf = fminf(1.f, diff / mu);
					float2 data = vol[pix];
					data.x = clamp((data.y * data.x + sdf) / (data.y + 1), -1.f,
							1.f);
					data.y = fminf(data.y + 1, maxweight);
					vol.set(pix, data);
				}
			}
		}
	TOCK("integrateKernel", vol.size.x * vol.size.y);
}
float4 raycast(const Volume volume, const uint2 pos, const Matrix4 view,
		const float nearPlane, const float farPlane, const float step,
		const float largestep) {

	const float3 origin = get_translation(view);
	const float3 direction = rotate(view, make_float3(pos.x, pos.y, 1.f));

	// intersect ray with a box
	// http://www.siggraph.org/education/materials/HyperGraph/raytrace/rtinter3.htm
	// compute intersection of ray with all six bbox planes
	const float3 invR = make_float3(1.0f) / direction;
	const float3 tbot = -1 * invR * origin;
	const float3 ttop = invR * (volume.dim - origin);

	// re-order intersections to find smallest and largest on each axis
	const float3 tmin = fminf(ttop, tbot);
	const float3 tmax = fmaxf(ttop, tbot);

	// find the largest tmin and the smallest tmax
	const float largest_tmin = fmaxf(fmaxf(tmin.x, tmin.y),
			fmaxf(tmin.x, tmin.z));
	const float smallest_tmax = fminf(fminf(tmax.x, tmax.y),
			fminf(tmax.x, tmax.z));

	// check against near and far plane
	const float tnear = fmaxf(largest_tmin, nearPlane);
	const float tfar = fminf(smallest_tmax, farPlane);

	if (tnear < tfar) {
		// first walk with largesteps until we found a hit
		float t = tnear;
		float stepsize = largestep;
		float f_t = volume.interp(origin + direction * t);
		float f_tt = 0;
		if (f_t > 0) { // ups, if we were already in it, then don't render anything here
			for (; t < tfar; t += stepsize) {
				f_tt = volume.interp(origin + direction * t);
				if (f_tt < 0)                  // got it, jump out of inner loop
					break;
				if (f_tt < 0.8f)               // coming closer, reduce stepsize
					stepsize = step;
				f_t = f_tt;
			}
			if (f_tt < 0) {           // got it, calculate accurate intersection
				t = t + stepsize * f_tt / (f_t - f_tt);
				return make_float4(origin + direction * t, t);
			}
		}
	}
	return make_float4(0);

}
void raycastKernel(float3* vertex, float3* normal, uint2 inputSize,
		const Volume integration, const Matrix4 view, const float nearPlane,
		const float farPlane, const float step, const float largestep) {
	TICK();
	unsigned int y;
#pragma omp parallel for \
	    shared(normal, vertex), private(y)
	for (y = 0; y < inputSize.y; y++)
		for (unsigned int x = 0; x < inputSize.x; x++) {

			uint2 pos = make_uint2(x, y);

			const float4 hit = raycast(integration, pos, view, nearPlane,
					farPlane, step, largestep);
			if (hit.w > 0.0) {
				vertex[pos.x + pos.y * inputSize.x] = make_float3(hit);
				float3 surfNorm = integration.grad(make_float3(hit));
				if (length(surfNorm) == 0) {
					//normal[pos] = normalize(surfNorm); // APN added
					normal[pos.x + pos.y * inputSize.x].x = KFUSION_INVALID;
				} else {
					normal[pos.x + pos.y * inputSize.x] = normalize(surfNorm);
				}
			} else {
				//std::cerr<< "RAYCAST MISS "<<  pos.x << " " << pos.y <<"  " << hit.w <<"\n";
				vertex[pos.x + pos.y * inputSize.x] = make_float3(0);
				normal[pos.x + pos.y * inputSize.x] = make_float3(KFUSION_INVALID, 0,
						0);
			}
		}
	TOCK("raycastKernel", inputSize.x * inputSize.y);
}

bool updatePoseKernel(Matrix4 & pose, const float * output,
		float icp_threshold) {
	bool res = false;
	TICK();
	// Update the pose regarding the tracking result
	TooN::Matrix<8, 32, const float, TooN::Reference::RowMajor> values(output);
	TooN::Vector<6> x = solve(values[0].slice<1, 27>());
	TooN::SE3<> delta(x);
	pose = toMatrix4(delta) * pose;

	// Return validity test result of the tracking
	if (norm(x) < icp_threshold)
		res = true;

	TOCK("updatePoseKernel", 1);
	return res;
}

bool checkPoseKernel(Matrix4 & pose, Matrix4 oldPose, const float * output,
		uint2 imageSize, float track_threshold) {

	// Check the tracking result, and go back to the previous camera position if necessary

	TooN::Matrix<8, 32, const float, TooN::Reference::RowMajor> values(output);

	if ((std::sqrt(values(0, 0) / values(0, 28)) > 2e-2)
			|| (values(0, 28) / (imageSize.x * imageSize.y) < track_threshold)) {
		pose = oldPose;
		return false;
	} else {
		return true;
	}

}

void renderNormalKernel(uchar3* out, const float3* normal, uint2 normalSize) {
	TICK();
	unsigned int y;
#pragma omp parallel for \
        shared(out), private(y)
	for (y = 0; y < normalSize.y; y++)
		for (unsigned int x = 0; x < normalSize.x; x++) {
			uint pos = (x + y * normalSize.x);
			float3 n = normal[pos];
			if (n.x == -2) {
				out[pos] = make_uchar3(0, 0, 0);
			} else {
				n = normalize(n);
				out[pos] = make_uchar3(n.x * 128 + 128, n.y * 128 + 128,
						n.z * 128 + 128);
			}
		}
	TOCK("renderNormalKernel", normalSize.x * normalSize.y);
}

void renderDepthKernel(uchar4* out, float * depth, uint2 depthSize,
		const float nearPlane, const float farPlane) {
	TICK();

	float rangeScale = 1 / (farPlane - nearPlane);

	unsigned int y;
#pragma omp parallel for \
        shared(out), private(y)
	for (y = 0; y < depthSize.y; y++) {
		int rowOffeset = y * depthSize.x;
		for (unsigned int x = 0; x < depthSize.x; x++) {

			unsigned int pos = rowOffeset + x;

			if (depth[pos] < nearPlane)
				out[pos] = make_uchar4(255, 255, 255, 0); // The forth value is a padding in order to align memory
			else {
				if (depth[pos] > farPlane)
					out[pos] = make_uchar4(0, 0, 0, 0); // The forth value is a padding in order to align memory
				else {
					const float d = (depth[pos] - nearPlane) * rangeScale;
					out[pos] = gs2rgb(d);
				}
			}
		}
	}
	TOCK("renderDepthKernel", depthSize.x * depthSize.y);
}

void renderTrackKernel(uchar4* out, const TrackData* data, uint2 outSize) {
	TICK();

	unsigned int y;
#pragma omp parallel for \
        shared(out), private(y)
	for (y = 0; y < outSize.y; y++)
		for (unsigned int x = 0; x < outSize.x; x++) {
			uint pos = x + y * outSize.x;
			switch (data[pos].result) {
			case 1:
				out[pos] = make_uchar4(128, 128, 128, 0);  // ok	 GREY
				break;
			case -1:
				out[pos] = make_uchar4(0, 0, 0, 0);      // no input BLACK
				break;
			case -2:
				out[pos] = make_uchar4(255, 0, 0, 0);        // not in image RED
				break;
			case -3:
				out[pos] = make_uchar4(0, 255, 0, 0);    // no correspondence GREEN
				break;
			case -4:
				out[pos] = make_uchar4(0, 0, 255, 0);        // to far away BLUE
				break;
			case -5:
				out[pos] = make_uchar4(255, 255, 0, 0);     // wrong normal YELLOW
				break;
			default:
				out[pos] = make_uchar4(255, 128, 128, 0);
				break;
			}
		}
	TOCK("renderTrackKernel", outSize.x * outSize.y);
}

void renderVolumeKernel(uchar4* out, const uint2 depthSize, const Volume volume,
		const Matrix4 view, const float nearPlane, const float farPlane,
		const float step, const float largestep, const float3 light,
		const float3 ambient) {
	TICK();
	unsigned int y;
#pragma omp parallel for \
        shared(out), private(y)
	for (y = 0; y < depthSize.y; y++) {
		for (unsigned int x = 0; x < depthSize.x; x++) {
			const uint pos = x + y * depthSize.x;

			float4 hit = raycast(volume, make_uint2(x, y), view, nearPlane,
					farPlane, step, largestep);
			if (hit.w > 0) {
				const float3 test = make_float3(hit);
				const float3 surfNorm = volume.grad(test);
				if (length(surfNorm) > 0) {
					const float3 diff = normalize(light - test);
					const float dir = fmaxf(dot(normalize(surfNorm), diff),
							0.f);
					const float3 col = clamp(make_float3(dir) + ambient, 0.f,
							1.f) * 255;
					out[pos] = make_uchar4(col.x, col.y, col.z, 0); // The forth value is a padding to align memory
				} else {
					out[pos] = make_uchar4(0, 0, 0, 0); // The forth value is a padding to align memory
				}
			} else {
				out[pos] = make_uchar4(0, 0, 0, 0); // The forth value is a padding to align memory
			}
		}
	}
	TOCK("renderVolumeKernel", depthSize.x * depthSize.y);
}

bool Kfusion::preprocessing(const ushort * inputDepth, const uint2 inSize,uint frame) {

	mm2metersKernel(floatDepth, computationSize, inputDepth, inSize);
/*

	TICK();

	

	// bilateral_filter(ScaledDepth[0], inputDepth, inputSize , gaussian, e_delta, radius);


///mm2meters kernel
	uint2 outSize = computationSize;

	// Check for unsupported conditions
	if ((inSize.x < outSize.x) || (inSize.y < outSize.y)) {
		std::cerr << "Invalid ratio." << std::endl;
		exit(1);
	}
	if ((inSize.x % outSize.x != 0) || (inSize.y % outSize.y != 0)) {
		std::cerr << "Invalid ratio." << std::endl;
		exit(1);
	}
	if ((inSize.x / outSize.x != inSize.y / outSize.y)) {
		std::cerr << "Invalid ratio." << std::endl;
		exit(1);
	}

	int ratio = inSize.x / outSize.x;

	if (computationSizeBkp.x < inSize.x|| computationSizeBkp.y < inSize.y || ocl_depth_buffer == NULL) {
		computationSizeBkp = make_uint2(inSize.x, inSize.y);
		if (ocl_depth_buffer != NULL) {
			clError = clReleaseMemObject(ocl_depth_buffer);
			checkErr(clError, "clReleaseMemObject");
		}
		ocl_depth_buffer = clCreateBuffer(context, CL_MEM_READ_WRITE,
				inSize.x * inSize.y * sizeof(uint16_t), NULL, &clError);
		checkErr(clError, "clCreateBuffer input");
	}
	clError = clEnqueueWriteBuffer(queue, ocl_depth_buffer, CL_FALSE, 0,
			inSize.x * inSize.y * sizeof(uint16_t), inputDepth, 0, NULL, &write_event[0]);
	checkErr(clError, "clEnqueueWriteBuffer");

	int arg = 0;
	clError = clSetKernelArg(mm2meters_ocl_kernel, arg++, sizeof(cl_mem),
			&ocl_FloatDepth);
	checkErr(clError, "clSetKernelArg");
	clError = clSetKernelArg(mm2meters_ocl_kernel, arg++, sizeof(cl_uint),
			&outSize.x);
	checkErr(clError, "clSetKernelArg");
 	clError = clSetKernelArg(mm2meters_ocl_kernel, arg++, sizeof(cl_uint),
			&outSize.y);
	checkErr(clError, "clSetKernelArg");
	clError = clSetKernelArg(mm2meters_ocl_kernel, arg++, sizeof(cl_mem),
			&ocl_depth_buffer);
	checkErr(clError, "clSetKernelArg");
	clError = clSetKernelArg(mm2meters_ocl_kernel, arg++, sizeof(cl_uint),
			&inSize.x);
	checkErr(clError, "clSetKernelArg");
	clError = clSetKernelArg(mm2meters_ocl_kernel, arg++, sizeof(cl_int),
			&ratio);
	checkErr(clError, "clSetKernelArg");

	size_t globalWorksize[2] = { outSize.x, outSize.y };

	clError = clEnqueueNDRangeKernel(queue, mm2meters_ocl_kernel, 2,
			NULL, globalWorksize, NULL, 0, &write_event[0], &kernel_event[0]);
	checkErr(clError, "clEnqueueNDRangeKernel");



	//This is done so that floatDepth=ocl_FloatDepth,because they are essentially the same thing and floatDepth get reads in renderDepth function, and next kernel(bilateral filter) , and integrateKernel

	clError = clEnqueueReadBuffer(queue,ocl_FloatDepth, CL_FALSE, 0,outSize.x * outSize.y * sizeof(float), floatDepth, 0,&kernel_event[0], &finish_event[0]);
	checkErr(clError, "clEnqueueReadBuffer");

	TOCK("mm2metersKernel", outSize.x * outSize.y);

////end of mm2meters kernels
	//timings
	

	write_vector.push_back( computeEventDuration(&write_event[0]) );
	kernel_vector.push_back(computeEventDuration(&kernel_event[0]) );
	read_vector.push_back ( computeEventDuration(&finish_event[0]) );

	//std::cerr << "Write to kernel time:" << computeEventDuration(&write_event[0]) << std::endl;
	//std::cerr << "Kernel time:" << computeEventDuration(&kernel_event[0]) << std::endl;
	//std::cerr << "Write to host time:" << computeEventDuration(&finish_event[0]) << std::endl;

*/

/*
	TICK();

   
	int arg = 0;
  float mult_result=2*e_delta*e_delta; 
     
	uint2 outSize = computationSize;
	size_t globalWorksize[2] = { outSize.x, outSize.y };
	

	//data write from host to kernel memory

	clError = clEnqueueWriteBuffer(queue, ocl_gaussian, CL_TRUE, 0,
			gaussianS * sizeof(float), gaussian, 0, NULL, NULL);
		checkErr(clError, "clEnqueueWrite");
	free(gaussian);
 
 
	//reading data to the kernel memory from host
	clError = clEnqueueWriteBuffer(queue,ocl_FloatDepth, CL_FALSE, 0,outSize.x * outSize.y * sizeof(float), floatDepth, 0,NULL, &write_event[0]);
	checkErr(clError, "clEnqueueWriteBuffer");

	//clError = clEnqueueWriteBuffer(commandQueue,ocl_ScaledDepth[0], CL_TRUE, 0,outSize.x * outSize.y * sizeof(float), ScaledDepth[0], 0,NULL, NULL);
	//checkErr(clError, "clEnqueueWriteBuffer");


	//setting arguments
	clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
			&ocl_ScaledDepth[0]);
	checkErr(clError, "clSetKernelArg");
	clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
			&ocl_FloatDepth);
	checkErr(clError, "clSetKernelArg");
	clError = clSetKernelArg(kernel, arg++,
			sizeof(cl_float), &mult_result);
	checkErr(clError, "clSetKernelArg");
	clError = clSetKernelArg(kernel, arg++, sizeof(cl_int),
			&radius);
	checkErr(clError, "clSetKernelArg");
	//std::cout<<radius<<std::endl;
 	clError = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
			&outSize);
	checkErr(clError, "clSetKernelArg");

 
 
 
	clError = clEnqueueTask(queue, kernel, 1, &write_event[0], &kernel_event[0]);
	checkErr(clError, "clEnqueueNDRangeKernel");

	//read data back from kernel scaled_depth=ocl_scaled_depth
	clError = clEnqueueReadBuffer(queue,ocl_ScaledDepth[0], CL_TRUE, 0,outSize.x * outSize.y * sizeof(float), ScaledDepth[0], 1,&kernel_event[0], &finish_event[0]);
	checkErr(clError, "clEnqueueReadBuffer");


	TOCK("bilateralfilterkernel", outSize.x * outSize.y);

//////end of bilateral filter kernel	

	//timings
	

	write_vector.push_back( computeEventDuration(&write_event[0]) );
	kernel_vector.push_back(computeEventDuration(&kernel_event[0]) );
	read_vector.push_back ( computeEventDuration(&finish_event[0]) );

	//std::cerr << "Write to kernel time:" << computeEventDuration(&write_event[0]) << std::endl;
	std::cerr << "Kernel time:" << computeEventDuration(&kernel_event[0]) << std::endl;
	//std::cerr << "Write to host time:" << computeEventDuration(&finish_event[0]) << std::endl;
*/


	bilateralFilterKernel(ScaledDepth[0], floatDepth, computationSize, gaussian,e_delta, radius);

	return true;
}

bool Kfusion::tracking(float4 k, float icp_threshold, uint tracking_rate,
		uint frame) {

	if (frame % tracking_rate != 0)
		return false;


  //C++ version of half sample
	// half sample the input depth maps into the pyramid levels
 
 
	for (unsigned int i = 1; i < iterations.size(); ++i) {
		halfSampleRobustImageKernel(ScaledDepth[i], ScaledDepth[i - 1],
				make_uint2(computationSize.x / (int) pow(2, i - 1),
						computationSize.y / (int) pow(2, i - 1)), e_delta * 3, 1);
	}



/*


	//data write from host to kernel memory
	clError = clEnqueueWriteBuffer(queue,ocl_ScaledDepth[0], CL_FALSE, 0,computationSize.x * computationSize.y * sizeof(float), ScaledDepth[0], 0, NULL, &write_event[0]);
	checkErr(clError, "clEnqueueReadBuffer");

/////////////////



	// half sample the input depth maps into the pyramid levels
	for (unsigned int i = 1; i < iterations.size(); ++i) {
		//halfSampleRobustImage(ScaledDepth[i], ScaledDepth[i-1], make_uint2( inputSize.x  / (int)pow(2,i) , inputSize.y / (int)pow(2,i) )  , e_delta * 3, 1);
		uint2 outSize = make_uint2(computationSize.x / (int) pow(2, i),
				computationSize.y / (int) pow(2, i));

		float e_d = e_delta * 3;
		int r = 1;
		uint2 inSize = outSize * 2;

		//std::cout<<inSize.x<<"  "<<inSize.y<<std::endl;

		int arg = 0;
		clError = clSetKernelArg(kernel, arg++,
				sizeof(cl_mem), &ocl_ScaledDepth[i]);
		checkErr(clError, "clSetKernelArg");
		clError = clSetKernelArg(kernel, arg++,
				sizeof(cl_mem), &ocl_ScaledDepth[i - 1]);
		checkErr(clError, "clSetKernelArg");
		clError = clSetKernelArg(kernel, arg++,
				sizeof(cl_uint2), &inSize);
		checkErr(clError, "clSetKernelArg");
		clError = clSetKernelArg(kernel, arg++,
				sizeof(cl_float), &e_d);
		checkErr(clError, "clSetKernelArg");


 	  clError = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
			&outSize);
	  checkErr(clError, "clSetKernelArg");



		size_t globalWorksize[2] = { outSize.x, outSize.y };


 
	clError = clEnqueueTask(queue, kernel, 1,&write_event[0] , &kernel_event[i-1]);
	checkErr(clError, "clEnqueueNDRangeKernel");
 
 

////////////	read data back from kernel scaled_depth=ocl_scaled_depth
		clError = clEnqueueReadBuffer(queue,ocl_ScaledDepth[i], CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(float)/(int) pow(2, i), ScaledDepth[i], 1, &kernel_event[i-1], &finish_event[i-1]);
		checkErr(clError, "clEnqueueReadBuffer");
	}



///////////////

  float sum_write=0;
  float sum_kernel=0;
  float sum_read=0;
  
	//timings
  for(int j=1;j<iterations.size();j++){
  sum_kernel+=(computeEventDuration(&kernel_event[j-1]) );
  sum_read += (computeEventDuration(&finish_event[j-1]));
  }

	write_vector.push_back( computeEventDuration(&write_event[0]) );
	kernel_vector.push_back( sum_kernel/(iterations.size()-1));
	read_vector.push_back (sum_read/ (iterations.size()-1));

 	std::cerr << "Write to kernel time:" << computeEventDuration(&write_event[0]) << std::endl;
	std::cerr << "Kernel time:" << computeEventDuration(&kernel_event[0]) << std::endl;
   std::cerr << "Kernel time:" << computeEventDuration(&kernel_event[1]) << std::endl;
	//std::cerr << "Write to host time:" << computeEventDuration(&finish_event[0]) << std::endl;




//////////////

*/



///////////////////////////////////////for depth2vertex before loop
/*
		//data write from host to kernel memory
		clError = clEnqueueWriteBuffer(queue,ocl_ScaledDepth[0], CL_FALSE, 0,computationSize.x * computationSize.y/ (int) pow(2, 0) * sizeof(float), ScaledDepth[0], 0, NULL, &write_event[0]);
		checkErr(clError, "clEnqueueReadBuffer");


		//data write from host to kernel memory
		clError = clEnqueueWriteBuffer(queue,ocl_ScaledDepth[1], CL_FALSE, 0,computationSize.x * computationSize.y/ (int) pow(2, 1) * sizeof(float), ScaledDepth[1], 1,  &write_event[0], &write_event[1]);
		checkErr(clError, "clEnqueueReadBuffer");


		//data write from host to kernel memory
		clError = clEnqueueWriteBuffer(queue,ocl_ScaledDepth[2], CL_FALSE, 0,computationSize.x * computationSize.y / (int) pow(2, 2)* sizeof(float), ScaledDepth[2], 1, &write_event[1], &write_event[2]);
		checkErr(clError, "clEnqueueReadBuffer");
	/////////////////////////////////////////////////////////////////

   
  cl_mem  invK_buffer=clCreateBuffer(context, CL_MEM_READ_ONLY,sizeof(Matrix4),NULL,NULL);
///////////////////////depth2vertex
*/


	// prepare the 3D information from the input depth maps
	uint2 localimagesize = computationSize;
	for (unsigned int i = 0; i < iterations.size(); ++i) {
		Matrix4 invK = getInverseCameraMatrix(k / float(1 << i));
   

		depth2vertexKernel(inputVertex[i], ScaledDepth[i], localimagesize,
				invK);
 
 /*
 ///////depth2vertex kernel
     clError = clEnqueueWriteBuffer(queue,invK_buffer, CL_TRUE, 0, sizeof(Matrix4), &invK, 0, NULL, NULL);
    checkErr(clError, "clEnqueueReadBuffer");
    
		uint2 imageSize = localimagesize;
		// Create kernel

		int arg = 0;
		clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
				&ocl_inputVertex[i]);
		checkErr(clError, "clSetKernelArg");
		clError = clSetKernelArg(kernel, arg++,
				sizeof(cl_uint2), &imageSize);
		checkErr(clError, "clSetKernelArg");
		clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
				&ocl_ScaledDepth[i]);
		checkErr(clError, "clSetKernelArg");
		clError = clSetKernelArg(kernel, arg++,
				sizeof(cl_uint2), &imageSize);
		checkErr(clError, "clSetKernelArg");
		clError = clSetKernelArg(kernel, arg++,
				sizeof(cl_mem), &invK_buffer);
		checkErr(clError, "clSetKernelArg");
   
 		clError = clSetKernelArg(kernel, arg++,
				sizeof(cl_uint2), &imageSize);
		checkErr(clError, "clSetKernelArg");

		size_t globalWorksize[2] = { imageSize.x, imageSize.y };


		clError = clEnqueueTask (queue, kernel, 1, &write_event[2], &kernel_event[i]);
		checkErr(clError, "clEnqueueNDRangeKernel");



////////////	read data back from kernel inpit_vertex=ocl_input_vertex
		clError = clEnqueueReadBuffer(queue,ocl_inputVertex[i], CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(float3)/(int) pow(2, i), inputVertex[i], 1,&kernel_event[i], &finish_event[i]);
		checkErr(clError, "clEnqueueReadBuffer");


///////////////depth2vertex kernel

 */
        
               
		vertex2normalKernel(inputNormal[i], inputVertex[i], localimagesize);
   
   
   
/*   

		//data write from host to kernel memory
		clError = clEnqueueWriteBuffer(queue,ocl_inputVertex[0], CL_FALSE, 0,computationSize.x * computationSize.y/ (int) pow(2, 0) * sizeof(float3), inputVertex[0], 0, NULL, &write_event[0]);
		checkErr(clError, "clEnqueueReadBuffer");


		//data write from host to kernel memory
		clError = clEnqueueWriteBuffer(queue,ocl_inputVertex[1], CL_FALSE, 0,computationSize.x * computationSize.y/ (int) pow(2, 1) * sizeof(float3), inputVertex[1], 0, NULL, &write_event[1]);
		checkErr(clError, "clEnqueueReadBuffer");


		//data write from host to kernel memory
		clError = clEnqueueWriteBuffer(queue,ocl_inputVertex[2], CL_FALSE, 0,computationSize.x * computationSize.y / (int) pow(2, 2)* sizeof(float3), inputVertex[2], 0, NULL, &write_event[2]);
		checkErr(clError, "clEnqueueReadBuffer");
	/////////////////

	  uint2 imageSize = localimagesize;

		int arg = 0;
		clError = clSetKernelArg(kernel, arg++,
				sizeof(cl_mem), &ocl_inputNormal[i]);
		checkErr(clError, "clSetKernelArg");
		clError = clSetKernelArg(kernel, arg++,
				sizeof(cl_uint2), &imageSize);
		checkErr(clError, "clSetKernelArg");
		clError = clSetKernelArg(kernel, arg++,
				sizeof(cl_mem), &ocl_inputVertex[i]);
		checkErr(clError, "clSetKernelArg");
		clError = clSetKernelArg(kernel, arg++,
				sizeof(cl_uint2), &imageSize);
		checkErr(clError, "clSetKernelArg");

 		clError = clSetKernelArg(kernel, arg++,
				sizeof(cl_uint2), &imageSize);
		checkErr(clError, "clSetKernelArg");
   
		size_t globalWorksize2[2] = { imageSize.x, imageSize.y };


		clError = clEnqueueTask (queue, kernel, 1, &write_event[2], &kernel_event[i]);
		checkErr(clError, "clEnqueueNDRangeKernel");
   
   
////////////	read data back from kernel inpit_vertex=ocl_input_vertex
		clError = clEnqueueReadBuffer(queue,ocl_inputNormal[i], CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(float3)/(int) pow(2, i), inputNormal[i], 1, &kernel_event[i], &finish_event[i]);
		checkErr(clError, "clEnqueueReadBuffer");


///////////////
*/  
  
		localimagesize = make_uint2(localimagesize.x / 2, localimagesize.y / 2);
	}
 
/* 
////timing vertext2normal

  float sum_write=0;
  float sum_kernel=0;
  float sum_read=0;
  
	//timings
  for(int j=0;j<iterations.size();j++){
  sum_write += (computeEventDuration(&write_event[j]) );
  sum_kernel+=(computeEventDuration(&kernel_event[j]) );
  sum_read += (computeEventDuration(&finish_event[j]));
  }

	write_vector.push_back( sum_write/(iterations.size()));
	kernel_vector.push_back( sum_kernel/(iterations.size()));
	read_vector.push_back (sum_read/ (iterations.size()));

    //std::cerr << "Average Write to kernel time:" << sum_write/(iterations.size()) << std::endl;
	 //std::cerr << "Average Kernel time:" << sum_kernel/(iterations.size()) << std::endl;
   //std::cerr << "Kernel time:" << computeEventDuration(&kernel_event[1]) << std::endl;
	 //std::cerr << "Average Write to host time:" << sum_read/ (iterations.size()) << std::endl;
/////////////      


////timing depth2vertex

  float sum_write=0;
  float sum_kernel=0;
  float sum_read=0;
  
	//timings
  for(int j=0;j<iterations.size();j++){
  sum_write += (computeEventDuration(&write_event[j]) );
  sum_kernel+=(computeEventDuration(&kernel_event[j]) );
  sum_read += (computeEventDuration(&finish_event[j]));
  }

	write_vector.push_back( sum_write/(iterations.size()));
	kernel_vector.push_back( sum_kernel/(iterations.size()));
	read_vector.push_back (sum_read/ (iterations.size()));

 	//std::cerr << "Write to kernel time:" << computeEventDuration(&write_event[0]) << std::endl;
	 //std::cerr << "Kernel time:" << computeEventDuration(&kernel_event[0]) << std::endl;
   //std::cerr << "Kernel time:" << computeEventDuration(&kernel_event[1]) << std::endl;
	//std::cerr << "Write to host time:" << computeEventDuration(&finish_event[0]) << std::endl;
/////////////      
*/




/*

		//data write from host to kernel memory


		//input vertex
		clError = clEnqueueWriteBuffer(queue,ocl_inputVertex[0], CL_FALSE, 0,computationSize.x * computationSize.y/ (int) pow(2, 0) * sizeof(float3), inputVertex[0], 0, NULL, &write_event[0]);
		checkErr(clError, "clEnqueueReadBuffer");


		//data write from host to kernel memory
		clError = clEnqueueWriteBuffer(queue,ocl_inputVertex[1], CL_FALSE, 0,computationSize.x * computationSize.y/ (int) pow(2, 1) * sizeof(float3), inputVertex[1], 0, NULL, &write_event[1]);
		checkErr(clError, "clEnqueueReadBuffer");


		//data write from host to kernel memory
		clError = clEnqueueWriteBuffer(queue,ocl_inputVertex[2], CL_FALSE, 0,computationSize.x * computationSize.y / (int) pow(2, 2)* sizeof(float3), inputVertex[2], 0, NULL, &write_event[2]);
		checkErr(clError, "clEnqueueReadBuffer");




		
		//input normal
		clError = clEnqueueWriteBuffer(queue,ocl_inputNormal[0], CL_FALSE, 0,computationSize.x * computationSize.y/ (int) pow(2, 0) * sizeof(float3), inputNormal[0], 0, NULL, &write_event[3]);
		checkErr(clError, "clEnqueueReadBuffer");


		//data write from host to kernel memory
		clError = clEnqueueWriteBuffer(queue,ocl_inputNormal[1], CL_FALSE, 0,computationSize.x * computationSize.y/ (int) pow(2, 1) * sizeof(float3), inputNormal[1], 0, NULL, &write_event[4]);
		checkErr(clError, "clEnqueueReadBuffer");


		//data write from host to kernel memory
		clError = clEnqueueWriteBuffer(queue,ocl_inputNormal[2], CL_FALSE, 0,computationSize.x * computationSize.y / (int) pow(2, 2)* sizeof(float3), inputNormal[2], 0, NULL, &write_event[5]);
		checkErr(clError, "clEnqueueReadBuffer");

		//normal
		clError = clEnqueueWriteBuffer(queue,ocl_normal, CL_FALSE, 0,computationSize.x * computationSize.y *sizeof(float3), normal, 0, NULL, &write_event[6]);
		checkErr(clError, "clEnqueueReadBuffer");

		//vertex
		clError = clEnqueueWriteBuffer(queue,ocl_vertex, CL_FALSE, 0,computationSize.x * computationSize.y *sizeof(float3), vertex, 0, NULL, &write_event[7]);
		checkErr(clError, "clEnqueueReadBuffer");



/////////////////////


  */  
    
    


	oldPose = pose;
	const Matrix4 projectReference = getCameraMatrix(k) * inverse(raycastPose);
  int read_counter=-1;
/*

////////track kernel

  
  cl_mem  pose_buffer=clCreateBuffer(context, CL_MEM_READ_ONLY,sizeof(Matrix4),NULL,NULL);
  cl_mem  project_buffer=clCreateBuffer(context, CL_MEM_READ_ONLY,sizeof(Matrix4),NULL,NULL);
  
  

///////////////////    
*/    

	for (int level = iterations.size() - 1; level >= 0; --level) {
		uint2 localimagesize = make_uint2(
				computationSize.x / (int) pow(2, level),
				computationSize.y / (int) pow(2, level));
		for (int i = 0; i < iterations[level]; ++i) {

			trackKernel(trackingResult, inputVertex[level], inputNormal[level],
					localimagesize, vertex, normal, computationSize, pose,
					projectReference, dist_threshold, normal_threshold);
      
/*      
      clError = clEnqueueWriteBuffer(queue,pose_buffer, CL_FALSE, 0, sizeof(Matrix4), &pose, 0, NULL, NULL);
      checkErr(clError, "clEnqueueReadBuffer");
      
      clError = clEnqueueWriteBuffer(queue,project_buffer, CL_FALSE, 0, sizeof(Matrix4), &projectReference, 0, NULL, &write_event[8]);
      checkErr(clError, "clEnqueueReadBuffer");
  
 	    int arg = 0;
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&ocl_trackingResult);
			checkErr(clError, "clSetKernelArg");
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
					&computationSize);
			checkErr(clError, "clSetKernelArg");
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&ocl_inputVertex[level]);
			checkErr(clError, "clSetKernelArg");
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
					&localimagesize);
			checkErr(clError, "clSetKernelArg");
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&ocl_inputNormal[level]);
			checkErr(clError, "clSetKernelArg");
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
					&localimagesize);
			checkErr(clError, "clSetKernelArg");
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&ocl_vertex);
			checkErr(clError, "clSetKernelArg");
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
					&computationSize);
			checkErr(clError, "clSetKernelArg");
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&ocl_normal);
			checkErr(clError, "clSetKernelArg");
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
					&computationSize);
			checkErr(clError, "clSetKernelArg");
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&pose_buffer);
			checkErr(clError, "clSetKernelArg");
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&project_buffer);
			checkErr(clError, "clSetKernelArg");
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_float),
					&dist_threshold);
			checkErr(clError, "clSetKernelArg");
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_float),
					&normal_threshold);
			checkErr(clError, "clSetKernelArg");
      
      clError = clSetKernelArg(kernel, arg++,
      sizeof(cl_uint2), &localimagesize);
      checkErr(clError, "clSetKernelArg");

			size_t globalWorksize[2] = { localimagesize.x, localimagesize.y };

			clError = clEnqueueNDRangeKernel(queue, kernel, 2,
					NULL, globalWorksize, NULL,1, &write_event[8], &kernel_event[++read_counter]);
			checkErr(clError, "clEnqueueNDRangeKernel");



		//clError = clEnqueueTask (queue, kernel, 1, &write_event[8], &kernel_event[++read_counter]);
		//checkErr(clError, "clEnqueueNDRangeKernel");
	

			////////////	read data back from kernel 
					clError = clEnqueueReadBuffer(queue,ocl_trackingResult, CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(TrackData), trackingResult, 1, &kernel_event[read_counter], &finish_event[read_counter]);
					checkErr(clError, "clEnqueueReadBuffer");


      
*/
      
      
      
                              

			reduceKernel(reductionoutput, trackingResult, computationSize,
					localimagesize);
      
      
      
/*      
      
		//data write from host to kernel memory

		//tracking result to host


 

		clError = clEnqueueWriteBuffer(queue,ocl_trackingResult, CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(TrackData), trackingResult, 0, NULL, &write_event[++read_counter]);
		checkErr(clError, "clEnqueueReadBuffer");





		/////////////////


			int arg = 0;
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&ocl_reduce_output_buffer);
			checkErr(clError, "clSetKernelArg");
      

      
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&ocl_trackingResult);
			checkErr(clError, "clSetKernelArg");
      
      
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
					&computationSize);
			checkErr(clError, "clSetKernelArg");
      
      
			clError = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
					&localimagesize);
			checkErr(clError, "clSetKernelArg");
      
      
			clError = clSetKernelArg(kernel, arg++,
					size_of_group * 32 * sizeof(float), NULL);
			checkErr(clError, "clSetKernelArg");

			size_t RglobalWorksize[1] = { size_of_group * number_of_groups };
			size_t RlocalWorksize[1] = { size_of_group }; // Dont change it !


			clError = clEnqueueNDRangeKernel(queue, kernel, 1,
					NULL, RglobalWorksize, RlocalWorksize, 0, NULL, &kernel_event[read_counter]);
			checkErr(clError, "clEnqueueNDRangeKernel");




			////////////	read data back from kernel 
			clError = clEnqueueReadBuffer(queue,
					ocl_reduce_output_buffer, CL_TRUE, 0,
					32 * number_of_groups * sizeof(float), reductionoutput, 0,
					NULL, &finish_event[read_counter]);
			checkErr(clError, "clEnqueueReadBuffer");




      
			TooN::Matrix<TooN::Dynamic, TooN::Dynamic, float,
					TooN::Reference::RowMajor> values(reductionoutput,
					number_of_groups, 32);

			for (int j = 1; j < number_of_groups; ++j) {
				values[0] += values[j];
			}
      
*/     
			if (updatePoseKernel(pose, reductionoutput, icp_threshold))
				break;

		}
 
	}
 
 
 /*   
   ////timing track kernel
  
    float sum_write=0;
    float sum_kernel=0;
    float sum_read=0;
    
    
    for(int i=0;i<8;i++){
      sum_write += (computeEventDuration(&write_event[i]) );
    }
  	//timings
    for(int j=0;j<read_counter;j++){
    //sum_write += (computeEventDuration(&write_event[j]) );
    sum_kernel+=(computeEventDuration(&kernel_event[j]) );
    sum_read += (computeEventDuration(&finish_event[j]));
    }
  
  	write_vector.push_back( sum_write/8);
   
  	kernel_vector.push_back( sum_kernel/read_counter);
  	read_vector.push_back (sum_read/ read_counter);
  
      //std::cerr << "Average Write to kernel time:" << sum_write/(iterations.size()) << std::endl;
  	 //std::cerr << "Average Kernel time:" << sum_kernel/(iterations.size()) << std::endl;
     //std::cerr << "Kernel time:" << computeEventDuration(&kernel_event[1]) << std::endl;
  	 //std::cerr << "Average Write to host time:" << sum_read/ (iterations.size()) << std::endl;
     
*/   

/*   
   ////timing reduce kernel
  
    float sum_write=0;
    float sum_kernel=0;
    float sum_read=0;
    
    //number of writes
    for(int i=0;i<1;i++){
      sum_write += (computeEventDuration(&write_event[i]) );
    }
  	//timings
    for(int j=0;j<=read_counter;j++){
    //sum_write += (computeEventDuration(&write_event[j]) );
    sum_kernel+=(computeEventDuration(&kernel_event[j]) );
    sum_read += (computeEventDuration(&finish_event[j]));
    }
  
  	write_vector.push_back( sum_write/1);
   
  	kernel_vector.push_back( sum_kernel/ (read_counter+1) );
  	read_vector.push_back (sum_read/ (read_counter+1) );
  
  

      //std::cerr << "Average Write to kernel time:" << sum_write/(read_counter+1) << std::endl;
  	 std::cerr << "Average Kernel time:" << sum_kernel/(read_counter+1) << std::endl;
     //std::cerr << "Kernel time:" << computeEventDuration(&kernel_event[1]) << std::endl;
  	 //std::cerr << "Average Write to host time:" << sum_read/ (read_counter+1) << std::endl;
     

*/   
      
	return checkPoseKernel(pose, oldPose, reductionoutput, computationSize,
			track_threshold);

}

bool Kfusion::raycasting(float4 k, float mu, uint frame) {

	bool doRaycast = false;

	if (frame > 2) {
		//raycastPose = pose;
		//raycastKernel(vertex, normal, computationSize, volume,
		//		raycastPose * getInverseCameraMatrix(k), nearPlane, farPlane,
		//		step, 0.75f * mu);
   
   
   
   ////////////////////////////////////
   

		//data write from host to kernel memory

		//tracking result to host
    /*
		clError = clEnqueueWriteBuffer(queue,ocl_normal, CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(float3), normal, 0, NULL, &write_event[0]);
		checkErr(clError, "clEnqueueReadBuffer");

		clError = clEnqueueWriteBuffer(queue,ocl_vertex, CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(float3), vertex, 0, NULL, &write_event[1]);
		checkErr(clError, "clEnqueueReadBuffer");
*/

		clError = clEnqueueWriteBuffer(queue,
				ocl_volume_data, CL_TRUE, 0,
				 volumeResolution.x * volumeResolution.y
					* volumeResolution.z * sizeof(short2), volume.data, 0,
				NULL, &write_event[0] );
		checkErr(clError, "clEnqueueReadBuffer");


		raycastPose = pose;
		const Matrix4 view = raycastPose * getInverseCameraMatrix(k);
    float largestep = mu * 0.75f;



      cl_mem  view_buffer=clCreateBuffer(context, CL_MEM_READ_ONLY,sizeof(Matrix4),NULL,NULL);
      clError = clEnqueueWriteBuffer(queue,view_buffer, CL_TRUE, 0, sizeof(Matrix4), &view, 0, NULL, NULL);
      checkErr(clError, "clEnqueueReadBuffer");
      
      
      
		// set param and run kernel
		clError = clSetKernelArg(kernel, 0, sizeof(cl_mem),
				(void*) &ocl_vertex);
		checkErr(clError, "clSetKernelArg0");
		clError = clSetKernelArg(kernel, 1, sizeof(cl_mem),
				(void*) &ocl_normal);
		checkErr(clError, "clSetKernelArg1");
		clError = clSetKernelArg(kernel, 2, sizeof(cl_mem),
				(void*) &ocl_volume_data);
		checkErr(clError, "clSetKernelArg2");
		clError = clSetKernelArg(kernel, 3, sizeof(cl_uint3),
				(void*) &volumeResolution);
		//std::cout<<"volume resolution:"<<volumeResolution.x<<" "<<volumeResolution.y<<" "<<volumeResolution.z<<std::endl;


		checkErr(clError, "clSetKernelArg3");
		clError = clSetKernelArg(kernel, 4, sizeof(cl_float3),
				(void*) &volumeDimensions);
		checkErr(clError, "clSetKernelArg4");
		//std::cout<<"volumeDimensions:"<<volumeDimensions.x<<" "<<volumeDimensions.y<<" "<<volumeDimensions.z<<std::endl;

		clError = clSetKernelArg(kernel, 5, sizeof(cl_mem),
				(void*) &view_buffer);
		checkErr(clError, "clSetKernelArg5");
		clError = clSetKernelArg(kernel, 6, sizeof(cl_float),
				(void*) &nearPlane);
		checkErr(clError, "clSetKernelArg6");
		clError = clSetKernelArg(kernel, 7, sizeof(cl_float),
				(void*) &farPlane);
		checkErr(clError, "clSetKernelArg7");
		clError = clSetKernelArg(kernel, 8, sizeof(cl_float),
				(void*) &step);
		//std::cout<<"step:"<<step<<std::endl;
		checkErr(clError, "clSetKernelArg8");
		clError = clSetKernelArg(kernel, 9, sizeof(cl_float),
				(void*) &largestep);
		checkErr(clError, "clSetKernelArg9");

		size_t RaycastglobalWorksize[2] =
				{ computationSize.x, computationSize.y };

		clError = clEnqueueNDRangeKernel(queue, kernel, 2,
				NULL, RaycastglobalWorksize, NULL, 0, NULL, &kernel_event[0]);
		checkErr(clError, "clEnqueueNDRangeKernel");





		////////////	read data back from kernel 
		clError = clEnqueueReadBuffer(queue,
				ocl_volume_data, CL_TRUE, 0,
				 volumeResolution.x * volumeResolution.y
					* volumeResolution.z * sizeof(short2), volume.data, 0,
				NULL, &finish_event[0]);
		checkErr(clError, "clEnqueueReadBuffer");



		clError = clEnqueueReadBuffer(queue,ocl_normal, CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(float3), normal, 0, NULL, &finish_event[1]);
		checkErr(clError, "clEnqueueReadBuffer");

		clError = clEnqueueReadBuffer(queue,ocl_vertex, CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(float3), vertex, 0, NULL, &finish_event[2]);
		checkErr(clError, "clEnqueueReadBuffer");


  	//timings
  	 float sum_read=0;
     
  	write_vector.push_back( computeEventDuration(&write_event[0]) );
  	kernel_vector.push_back(computeEventDuration(&kernel_event[0]) );
   
    for(int i=0;i<3;i++){
      sum_read += (computeEventDuration(&finish_event[i]) );
    }
 
  	read_vector.push_back( sum_read/3);
  
  	//std::cerr << "Write to kernel time:" << computeEventDuration(&write_event[0]) << std::endl;
  	 std::cerr << "Kernel time:" << computeEventDuration(&kernel_event[0]) << std::endl;
  	//std::cerr << "Write to host time:" << computeEventDuration(&finish_event[0]) << std::endl;

	}

	return doRaycast;

}

bool Kfusion::integration(float4 k, uint integration_rate, float mu,
		uint frame) {


	bool doIntegrate = checkPoseKernel(pose, oldPose, reductionoutput,
			computationSize, track_threshold);

	if ((doIntegrate && ((frame % integration_rate) == 0)) || (frame <= 3)) {
 
 
		integrateKernel(volume, floatDepth, computationSize, inverse(pose),
				getCameraMatrix(k), mu, maxweight);
   
   
		doIntegrate = true;
   
   
//////////////////////////////////////////////////   


/*
   	clError = clEnqueueWriteBuffer(queue,ocl_FloatDepth, CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(float), floatDepth, 0, NULL, &write_event[0]);
	checkErr(clError, "clEnqueueReadBuffer");

   
		uint2 depthSize = computationSize;
		const Matrix4 invTrack = inverse(pose);
		const Matrix4 K = getCameraMatrix(k);

////////////////must be done for AOCL

      cl_mem  invTrack_buffer=clCreateBuffer(context, CL_MEM_READ_ONLY,sizeof(Matrix4),NULL,NULL);
      cl_mem  K_buffer=clCreateBuffer(context, CL_MEM_READ_ONLY,sizeof(Matrix4),NULL,NULL);
  
  

      clError = clEnqueueWriteBuffer(queue,invTrack_buffer, CL_TRUE, 0, sizeof(Matrix4), &invTrack, 0, NULL, NULL);
      checkErr(clError, "clEnqueueReadBuffer");
      
      clError = clEnqueueWriteBuffer(queue,K_buffer, CL_TRUE, 0, sizeof(Matrix4), &K, 0, NULL, NULL);
      checkErr(clError, "clEnqueueReadBuffer");
/////////////////////////////////


		//uint3 pix = make_uint3(thr2pos2());
		const float3 delta = rotate(invTrack,
				make_float3(0, 0, volumeDimensions.z / volumeResolution.z));
		const float3 cameraDelta = rotate(K, delta);

		// set param and run kernel
		int arg = 0;
		clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
				(void*) &ocl_volume_data);
		checkErr(clError, "clSetKernelArg1");
		clError = clSetKernelArg(kernel, arg++, sizeof(cl_uint3),
				(void*) &volumeResolution);
		checkErr(clError, "clSetKernelArg2");
		clError = clSetKernelArg(kernel, arg++, sizeof(cl_float3),
				(void*) &volumeDimensions);
		checkErr(clError, "clSetKernelArg3");
		clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
				(void*) &ocl_FloatDepth);
		checkErr(clError, "clSetKernelArg4");
		clError = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
				(void*) &depthSize);
		checkErr(clError, "clSetKernelArg5");
		clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
				(void*) &invTrack_buffer);
		checkErr(clError, "clSetKernelArg6");
		clError = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
				(void*) &K_buffer);
		checkErr(clError, "clSetKernelArg7");
		clError = clSetKernelArg(kernel, arg++, sizeof(cl_float),
				(void*) &mu);
		checkErr(clError, "clSetKernelArg8");
		clError = clSetKernelArg(kernel, arg++, sizeof(cl_float),
				(void*) &maxweight);
		checkErr(clError, "clSetKernelArg9");

		clError = clSetKernelArg(kernel, arg++, sizeof(cl_float3),
				(void*) &delta);
		checkErr(clError, "clSetKernelArg10");
		clError = clSetKernelArg(kernel, arg++, sizeof(cl_float3),
				(void*) &cameraDelta);
		checkErr(clError, "clSetKernelArg11");

		size_t globalWorksize[2] = { volumeResolution.x, volumeResolution.y };

		clError = clEnqueueNDRangeKernel(queue, kernel, 2,
				NULL, globalWorksize,NULL,0, NULL, &kernel_event[0]);


	////////////	read data back from kernel 
	clError = clEnqueueReadBuffer(queue,
			ocl_volume_data, CL_TRUE, 0,
			 volumeResolution.x * volumeResolution.y
				* volumeResolution.z * sizeof(short2), volume.data, 0,
			NULL, &finish_event[0]);
	checkErr(clError, "clEnqueueReadBuffer");


	//timings
	
	write_vector.push_back( computeEventDuration(&write_event[0]) );
	kernel_vector.push_back(computeEventDuration(&kernel_event[0]) );
	read_vector.push_back ( computeEventDuration(&finish_event[0]) );

	//std::cerr << "Write to kernel time:" << computeEventDuration(&write_event[0]) << std::endl;
	 std::cerr << "Kernel time:" << computeEventDuration(&kernel_event[0]) << std::endl;
	//std::cerr << "Write to host time:" << computeEventDuration(&finish_event[0]) << std::endl;



*/


	} else {
		doIntegrate = false;
	}




	return doIntegrate;

}

void Kfusion::dumpVolume(std::string filename) {

	std::ofstream fDumpFile;

	if (filename == "") {
		return;
	}

	std::cout << "Dumping the volumetric representation on file: " << filename
			<< std::endl;
	fDumpFile.open(filename.c_str(), std::ios::out | std::ios::binary);
	if (fDumpFile.fail()) {
		std::cout << "Error opening file: " << filename << std::endl;
		exit(1);
	}

	// Dump on file without the y component of the short2 variable
	for (unsigned int i = 0; i < volume.size.x * volume.size.y * volume.size.z;
			i++) {
		fDumpFile.write((char *) (volume.data + i), sizeof(short));
	}

	fDumpFile.close();

}

void Kfusion::renderVolume(uchar4 * out, uint2 outputSize, int frame,
		int raycast_rendering_rate, float4 k, float largestep) {
	if (frame % raycast_rendering_rate == 0)
		renderVolumeKernel(out, outputSize, volume,
				*(this->viewPose) * getInverseCameraMatrix(k), nearPlane,
				farPlane * 2.0f, step, largestep, light, ambient);
}

void Kfusion::renderTrack(uchar4 * out, uint2 outputSize) {
	renderTrackKernel(out, trackingResult, outputSize);
}

void Kfusion::renderDepth(uchar4 * out, uint2 outputSize) {
	renderDepthKernel(out, floatDepth, outputSize, nearPlane, farPlane);
}

void Kfusion::computeFrame(const ushort * inputDepth, const uint2 inputSize,
			 float4 k, uint integration_rate, uint tracking_rate,
			 float icp_threshold, float mu, const uint frame) {
  preprocessing(inputDepth, inputSize,frame);
  _tracked = tracking(k, icp_threshold, tracking_rate, frame);
  _integrated = integration(k, integration_rate, mu, frame);
  raycasting(k, mu, frame);
}


void synchroniseDevices() {
	// Nothing to do in the C++ implementation
}
