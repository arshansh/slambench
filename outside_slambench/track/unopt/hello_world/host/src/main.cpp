// Copyright (C) 2013-2016 Altera Corporation, San Jose, California, USA. All rights reserved.
// Permission is hereby granted, free of charge, to any person obtaining a copy of this
// software and associated documentation files (the "Software"), to deal in the Software
// without restriction, including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to
// whom the Software is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
// 
// This agreement shall be governed in all respects by the laws of the State of California and
// by the laws of the United States of America.

///////////////////////////////////////////////////////////////////////////////////
// This host program runs a "hello world" kernel. This kernel prints out a
// message for if the work-item index matches a kernel argument.
//
// Most of this host program code is the basic elements of a OpenCL host
// program, handling the initialization and cleanup of OpenCL objects. The
// host program also makes queries through the OpenCL API to get various
// properties of the device.
///////////////////////////////////////////////////////////////////////////////////

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cstring>
#include "CL/opencl.h"
#include "AOCLUtils/aocl_utils.h"

#include <sstream>
#include <iomanip>
#include <iostream>
#include <stdbool.h>
#include <unistd.h>
#include <time.h>
#include <fstream>
#include <string>
#include "vector_types.h"


using namespace aocl_utils;

#define STRING_BUFFER_LEN 1024

// Runtime constants
// Used to define the work set over which this kernel will execute.
static const size_t work_group_size = 8;  // 8 threads in the demo workgroup
// Defines kernel argument value, which is the workitem ID that will
// execute a printf call
static const int thread_id_to_output = 2;

// OpenCL runtime configuration
static cl_platform_id platform = NULL;
static cl_device_id device = NULL;
static cl_context context = NULL;
static cl_command_queue queue = NULL;
static cl_kernel kernel = NULL;
static cl_program program = NULL;

///////
cl_uint num_devices;




typedef struct sMatrix4 {
	float4 data[4];
} Matrix4;






struct TrackData {
	int result;
	float error;
	float J[6];
};


////////
////////////////////////////////////////////

cl_mem * ocl_inputVertex = NULL;
float3 ** inputVertex;

cl_mem * ocl_inputNormal = NULL;
float3 ** inputNormal;


cl_mem ocl_trackingResult = NULL;
TrackData * trackingResult;

cl_mem ocl_vertex = NULL;
float3 * vertex;

cl_mem ocl_normal = NULL;
float3 * normal;

cl_mem ProjectReference_float_ocl=NULL;
cl_mem Pose_float_ocl=NULL;



//const uint computationSize.x=320;
//const uint computationSize.y=240;
uint2 computationSize = make_uint2(320,240);



const uint outSize_x=320;
const uint outSize_y=240;



//uint iterations.size()=3;
std::vector<int> iterations;  // max number of iterations per level

const int radius = 2;
const float delta = 4.0f;
const float e_delta = 0.1f;
const float dist_threshold = 0.1f;
const float normal_threshold = 0.8f;



// Function prototypes
bool init();
void cleanup();
static void device_info_ulong( cl_device_id device, cl_device_info param, const char* name);
static void device_info_uint( cl_device_id device, cl_device_info param, const char* name);
static void device_info_bool( cl_device_id device, cl_device_info param, const char* name);
static void device_info_string( cl_device_id device, cl_device_info param, const char* name);
static void display_device_info( cl_device_id device );


//functions needed




inline Matrix4 getCameraMatrix(const float4 & k) {
	Matrix4 K;
	K.data[0] = make_float4(k.x, 0, k.z, 0);
	K.data[1] = make_float4(0, k.y, k.w, 0);
	K.data[2] = make_float4(0, 0, 1, 0);
	K.data[3] = make_float4(0, 0, 0, 1);
	return K;
}


inline Matrix4 getInverseCameraMatrix(const float4 & k) {
	Matrix4 invK;
	invK.data[0] = make_float4(1.0f / k.x, 0, -k.z / k.x, 0);
	invK.data[1] = make_float4(0, 1.0f / k.y, -k.w / k.y, 0);
	invK.data[2] = make_float4(0, 0, 1, 0);
	invK.data[3] = make_float4(0, 0, 0, 1);
	return invK;
}



// Entry point.
int main() {
  cl_int status;

  if(!init()) {
    return -1;
  }


/////////////////////////////////////////////////	Declare things 	////////////////////////////////////////////////////////////////////////////////



	cl_event write_event[8];
	cl_event kernel_event[13];
	cl_event finish_event[13];


	//building iterations
	iterations.push_back(4);
	iterations.push_back(5);
	iterations.push_back(4);


	
	
	//ocl_inputVertex decleration
	ocl_inputVertex = (cl_mem*) malloc(sizeof(cl_mem) * iterations.size());
	
	//input_vertex decleration
	inputVertex = (float3**) calloc(sizeof(float3*) * iterations.size(), 1);

	
	//ocl input Normal decleration
	ocl_inputNormal = (cl_mem*) malloc(sizeof(cl_mem) * iterations.size());
	

	//inputNormal decleration
	inputNormal = (float3**) calloc(sizeof(float3*) * iterations.size(), 1);

	for (unsigned int i = 0; i < iterations.size(); ++i) {

		

		ocl_inputVertex[i] = clCreateBuffer(context, CL_MEM_READ_WRITE,
				sizeof(float3) * (computationSize.x * computationSize.y)
						/ (int) pow(2, i), NULL, &status);
			checkError(status, "clCreateBuffer");


		inputVertex[i] = (float3*) calloc(
				sizeof(float3) * (computationSize.x * computationSize.y)
						/ (int) pow(2, i), 1);




		ocl_inputNormal[i] =  clCreateBuffer(context, CL_MEM_READ_WRITE,
				sizeof(float3) * (computationSize.x * computationSize.y)
						/ (int) pow(2, i), NULL, &status);
			checkError(status, "clCreateBuffer");


		inputNormal[i] = (float3*) calloc(
				sizeof(float3) * (computationSize.x * computationSize.y)
						/ (int) pow(2, i), 1);


	}
	

	//tracking result decleration
	ocl_trackingResult = clCreateBuffer(context, CL_MEM_READ_WRITE,sizeof(TrackData) * computationSize.x * computationSize.y, NULL,&status);
	checkError(status, "clCreateBuffer");

	trackingResult = (TrackData*) calloc(
			sizeof(TrackData) * computationSize.x * computationSize.y, 1);

	//vertex decleration
	ocl_vertex = clCreateBuffer(context, CL_MEM_READ_WRITE,sizeof(float3) * computationSize.x * computationSize.y, NULL,&status);
		checkError(status, "clCreateBuffer");

		vertex = (float3*) calloc(sizeof(float3) * computationSize.x * computationSize.y, 1);

	//normal decleration
	ocl_normal = clCreateBuffer(context, CL_MEM_READ_WRITE,sizeof(float3) * computationSize.x * computationSize.y, NULL,&status);
		checkError(status, "clCreateBuffer");

	normal = (float3*) calloc(
			sizeof(float3) * computationSize.x * computationSize.y, 1);


/////////////////////////////////////////////	end of declare things /////////////////////////////////////////////////////////////////


//read from a file




	//input vertex
	std::ifstream myfile ("input_vertex_0.txt");
	
	for(int i=0;i<320*240;i++){
		
		myfile>> inputVertex[0][i].x>>inputVertex[0][i].y>>inputVertex[0][i].z;
	}

	std::cout<<"input read 1 success"<<std::endl;
	myfile.close();




	std::ifstream myfile1 ("input_vertex_1.txt");
	
	for(int i=0;i<160*120;i++){
		
		myfile1>> inputVertex[1][i].x>>inputVertex[1][i].y>>inputVertex[1][i].z;
	}

	std::cout<<"input read 2 success"<<std::endl;
	myfile1.close();


	std::ifstream myfile2 ("input_vertex_2.txt");
	
	for(int i=0;i<60*80;i++){
		
		myfile2>> inputVertex[2][i].x>>inputVertex[2][i].y>>inputVertex[2][i].z;
	}

	std::cout<<"input read 3 success"<<std::endl;
	myfile2.close();

	//input normal

	myfile.open ("input_normal_0.txt");
	
	for(int i=0;i<320*240;i++){
		
		myfile>> inputNormal[0][i].x>>inputNormal[0][i].y>>inputNormal[0][i].z;
	}

	std::cout<<"input read 4 success"<<std::endl;
	myfile.close();



	myfile1.open ("input_normal_1.txt");
	
	for(int i=0;i<160*120;i++){
		
		myfile1>> inputNormal[1][i].x>>inputNormal[1][i].y>>inputNormal[1][i].z;
	}

	std::cout<<"input read 5 success"<<std::endl;
	myfile1.close();


	myfile2.open ("input_normal_2.txt");
	
	for(int i=0;i<60*80;i++){
		
		myfile2>> inputNormal[2][i].x>>inputNormal[2][i].y>>inputNormal[2][i].z;
	}

	std::cout<<"input read 6 success"<<std::endl;
	myfile2.close();



	//normal
	myfile1.open("normal.txt");
	for(int i=0;i<(320*240);i++){
		myfile1>>normal[i].x>>normal[i].y>>normal[i].z;

	}
	std::cout<<"input read 7 success"<<std::endl;
	myfile1.close();


	//vertex
	myfile2.open("vertex.txt");
	for(int i=0;i<(320*240);i++){
		myfile2>>vertex[i].x>>vertex[i].y>>vertex[i].z;

	}
	std::cout<<"input read 8 success"<<std::endl;
	myfile2.close();





/*

	//input write 
	std::ofstream myfile7;
	myfile7.open("input_vertex_fpga_0.txt");
	for(int i=0;i<(320*240);i++){
		myfile7<<inputVertex[0][i].x<<" "<<inputVertex[0][i].y<<" "<<inputVertex[0][i].z<<std::endl;
	
	}
	std::cout<<"input write success"<<std::endl;
	myfile7.close();

*/

/////////////////////////////////////////////	building the kernel   /////////////////////////////////////////////////////////////////


	double start_time = getCurrentTimestamp();



/*
	//data write from host to kernel memory


	status = clEnqueueWriteBuffer(queue,ocl_inputVertex[0], CL_FALSE, 0,computationSize.x * computationSize.y * sizeof(float3)/ (int) pow(2, 0), inputVertex[0],  0, NULL, &write_event[0]);
	checkError(status, "clEnqueueReadBuffer");

	status = clEnqueueWriteBuffer(queue,ocl_inputVertex[1], CL_FALSE, 0,computationSize.x * computationSize.y * sizeof(float3)/ (int) pow(2, 1), inputVertex[1],  0, NULL, &write_event[1]);
	checkError(status, "clEnqueueReadBuffer");

	status = clEnqueueWriteBuffer(queue,ocl_inputVertex[2], CL_FALSE, 0,computationSize.x * computationSize.y * sizeof(float3)/ (int) pow(2, 2), inputVertex[2],  0, NULL, &write_event[2]);
	checkError(status, "clEnqueueReadBuffer");







	uint localimagesize_x=computationSize.x;
	uint localimagesize_y=computationSize.y;	


	

	for (unsigned int i = 0; i < iterations.size(); ++i) {






		
		// prepare the 3D information from the input depth maps
		uint imagesize_x = localimagesize_x;
		uint imagesize_y = localimagesize_y;

		// Create kernel
		//setting arguments


		int arg = 0;
		status = clSetKernelArg(kernel, arg++,
				sizeof(cl_mem), &ocl_inputNormal[i]);
		checkError(status, "clSetKernelArg");

		status = clSetKernelArg(kernel, arg++,
				sizeof(cl_uint), &imagesize_x);
		checkError(status, "clSetKernelArg");

		status = clSetKernelArg(kernel, arg++,
				sizeof(cl_uint), &imagesize_y);
		checkError(status, "clSetKernelArg");

		status = clSetKernelArg(kernel, arg++,
				sizeof(cl_mem), &ocl_inputVertex[i]);
		checkError(status, "clSetKernelArg");

		status = clSetKernelArg(kernel, arg++,
				sizeof(cl_uint), &imagesize_x);
		checkError(status, "clSetKernelArg");

		status = clSetKernelArg(kernel, arg++,
				sizeof(cl_uint), &imagesize_y);
		checkError(status, "clSetKernelArg");





         	  printf("\nKernel initialization is complete.\n");
		  printf("Launching the kernel...\n\n");


		// Launch the kernel


		size_t globalWorksize2[2] = { imagesize_x, imagesize_y };

		status = clEnqueueNDRangeKernel(queue, kernel,
				2,
				NULL, globalWorksize2, NULL, 1, &write_event[2], &kernel_event[i]);
		checkError(status, "clEnqueueNDRangeKernel");


	//status=clEnqueueTask(queue,kernel,1,&write_event[2],&kernel_event[i]);
			//checkError(status, "clEnqueueNDRangeKernel");




		//read data back from kernel scaled_depth=ocl_scaled_depth
		status = clEnqueueReadBuffer(queue,ocl_inputNormal[i], CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(float3)/ (int) pow(2, i), inputNormal[i], 1, &kernel_event[i], &finish_event[i]);
		checkError(status, "clEnqueueReadBuffer");




		localimagesize_x=localimagesize_x/2;
		localimagesize_y=localimagesize_y/2;

	}



*/










	//std::cout<<"data write from host to kernel memory"<<std::endl;




	//data write from host to kernel memory

	//input vertex
	status = clEnqueueWriteBuffer(queue,ocl_inputVertex[0], CL_FALSE, 0,computationSize.x * computationSize.y * sizeof(float3)/ (int) pow(2, 0), inputVertex[0],  0, NULL, &write_event[0]);
	checkError(status, "clEnqueueReadBuffer");

	status = clEnqueueWriteBuffer(queue,ocl_inputVertex[1], CL_FALSE, 0,computationSize.x * computationSize.y * sizeof(float3)/ (int) pow(2, 1), inputVertex[1],  0, NULL, &write_event[1]);
	checkError(status, "clEnqueueReadBuffer");

	status = clEnqueueWriteBuffer(queue,ocl_inputVertex[2], CL_FALSE, 0,computationSize.x * computationSize.y * sizeof(float3)/ (int) pow(2, 2), inputVertex[2],  0, NULL, &write_event[2]);
	checkError(status, "clEnqueueReadBuffer");


		
	//input normal
	status = clEnqueueWriteBuffer(queue,ocl_inputNormal[0], CL_TRUE, 0,computationSize.x * computationSize.y/ (int) pow(2, 0) * sizeof(float3), inputNormal[0], 0, NULL, &write_event[3]);
	checkError(status, "clEnqueueReadBuffer");


	//data write from host to kernel memory
	status = clEnqueueWriteBuffer(queue,ocl_inputNormal[1], CL_TRUE, 0,computationSize.x * computationSize.y/ (int) pow(2, 1) * sizeof(float3), inputNormal[1], 0, NULL, &write_event[4]);
	checkError(status, "clEnqueueReadBuffer");


	//data write from host to kernel memory
	status = clEnqueueWriteBuffer(queue,ocl_inputNormal[2], CL_TRUE, 0,computationSize.x * computationSize.y / (int) pow(2, 2)* sizeof(float3), inputNormal[2], 0, NULL, &write_event[5]);
	checkError(status, "clEnqueueReadBuffer");

	//normal
	status = clEnqueueWriteBuffer(queue,ocl_normal, CL_TRUE, 0,computationSize.x * computationSize.y *sizeof(float3), normal, 0, NULL, &write_event[6]);
	checkError(status, "clEnqueueReadBuffer");

	//vertex
	status = clEnqueueWriteBuffer(queue,ocl_vertex, CL_TRUE, 0,computationSize.x * computationSize.y *sizeof(float3), vertex, 0, NULL, &write_event[7]);
	checkError(status, "clEnqueueReadBuffer");









	//building pose
	Matrix4 pose,oldPose;
	float pose_array[16]={1,0,0,1.632000089,0,1,0,2.400000095,0, 0, 1 ,1.15200007,0, 0, 0, 1};
	int j=0;
	int i=-1;
	while(j<4){
		pose.data[j].x=pose_array[++i];
		pose.data[j].y=pose_array[++i];
		pose.data[j].z=pose_array[++i];
		pose.data[j].w=pose_array[++i];	
		j++;
	}
	oldPose = pose;


///////////////////////// In order to get projectReference
	//building k (camera)
	float4 k;
	float a=240.6000061;
	float b=240;
	float c=160;
	float d=120;
	
	k.x=a;
	k.y=b;
	k.z=c;
	k.w=d;

////////////////////////////

	//const Matrix4 projectReference = getCameraMatrix(k) * inverse(raycastPose);


	//building project reference manually
	Matrix4 projectReference;

	float projectReference_arr[16]={240.6000061, 0, 160, -576.979248,0, 240, 120, -714.2399902,0, 0 ,1 ,-1.15200007,0, 0, 0, 1};

	int q=0;
	int z=-1;
	while(q<4){
		projectReference.data[q].x=projectReference_arr[++z];
		projectReference.data[q].y=projectReference_arr[++z];
		projectReference.data[q].z=projectReference_arr[++z];
		projectReference.data[q].w=projectReference_arr[++z];	
		q++;
	}




	//copying pose array to opencl
	Pose_float_ocl=clCreateBuffer(context, CL_MEM_READ_WRITE,
	sizeof(float) * 16, NULL,&status);
	checkError(status, "clCreateBuffer");

	status = clEnqueueWriteBuffer(queue,Pose_float_ocl, CL_TRUE, 0, 16* sizeof(float),pose_array, 0, NULL, NULL);
	checkError(status, "clEnqueueReadBuffer");

	//copying projectReference array to opencl
	ProjectReference_float_ocl=clCreateBuffer(context, CL_MEM_READ_WRITE,sizeof(float) * 16, NULL,&status);
	checkError(status, "clCreateBuffer");

	status = clEnqueueWriteBuffer(queue,ProjectReference_float_ocl, CL_TRUE, 0, 16* sizeof(float),projectReference_arr, 0, NULL, NULL);
	checkError(status, "clEnqueueReadBuffer");









	int read_counter=-1;
	for (int level = iterations.size() - 1; level >= 0; --level) {

		uint2 localimagesize = make_uint2(
				computationSize.x / (int) pow(2, level),
				computationSize.y / (int) pow(2, level));


		for (int i = 0; i < iterations[level]; ++i) {




			// Create kernel
			//setting arguments
			int arg = 0;
			status = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&ocl_trackingResult);
			checkError(status, "clSetKernelArg");

			status = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
					&computationSize);
			checkError(status, "clSetKernelArg");

			status = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&ocl_inputVertex[level]);
			checkError(status, "clSetKernelArg");

			status = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
					&localimagesize);
			checkError(status, "clSetKernelArg");

			status = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&ocl_inputNormal[level]);
			checkError(status, "clSetKernelArg");

			status = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
					&localimagesize);
			checkError(status, "clSetKernelArg");

			status = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&ocl_vertex);
			checkError(status, "clSetKernelArg");

			status = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
					&computationSize);
			checkError(status, "clSetKernelArg");

			status = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&ocl_normal);
			checkError(status, "clSetKernelArg");

			status = clSetKernelArg(kernel, arg++, sizeof(cl_uint2),
					&computationSize);
			checkError(status, "clSetKernelArg");

			status = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&Pose_float_ocl);
			checkError(status, "clSetKernelArg");

			status = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
					&ProjectReference_float_ocl);
			checkError(status, "clSetKernelArg");

			status = clSetKernelArg(kernel, arg++, sizeof(cl_float),
					&dist_threshold);
			checkError(status, "clSetKernelArg");

			status = clSetKernelArg(kernel, arg++, sizeof(cl_float),
					&normal_threshold);
			checkError(status, "clSetKernelArg");





		 	  printf("\nKernel initialization is complete.\n");
			  printf("Launching the kernel...\n\n");


			// Launch the kernel



			size_t globalWorksize[2] = { localimagesize.x, localimagesize.y };

			status = clEnqueueNDRangeKernel(queue, kernel, 2,
					NULL, globalWorksize, NULL, 0, NULL, &kernel_event[++read_counter]);
			checkError(status, "clEnqueueNDRangeKernel");

			checkError(status, "clCreateBuffer output");



			////////////	read data back from kernel 
			status = clEnqueueReadBuffer(queue,ocl_trackingResult, CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(TrackData), trackingResult, 0, NULL, &finish_event[read_counter]);
			checkError(status, "clEnqueueReadBuffer");

		}

	}





////end of track kernel




/////////////////////////////////////////////	end of kernel execution /////////////////////////////////////////////////////////////////


/////////////////////////////////////////////	timing the kernel /////////////////////////////////////////////////////////////////




  // Wait for command queue to complete pending events
  status = clFinish(queue);
  checkError(status, "Failed to finish");

  // Wait for all devices to finish.
  clWaitForEvents(num_devices, &finish_event[2]);
 double end_time = getCurrentTimestamp();

  printf("\nKernel execution is complete.\n");

  // Wall-clock time taken.(seconds by default)
  printf("\nTime: %0.3f ms\n", (end_time - start_time) * 1e3);



    //default in ns
    cl_ulong kernel_time_ns1 = getStartEndTime(write_event[0]);
    printf("First Write to kernel time: %0.3f ms\n", double(kernel_time_ns1) *1e-6 );

    //default in ns
    cl_ulong kernel_time_ns2 = getStartEndTime(write_event[1]);
    printf("Second Write to kernel time: %0.3f ms\n", double(kernel_time_ns2) *1e-6 );

    //default in ns
    cl_ulong kernel_time_ns3 = getStartEndTime(write_event[2]);
    printf("Third Write to kernel time: %0.3f ms\n", double(kernel_time_ns3) *1e-6 );

    //default in ns
    cl_ulong kernel_time_ns4 = getStartEndTime(write_event[3]);
    printf("Fourth Write to kernel time: %0.3f ms\n", double(kernel_time_ns4) *1e-6 );

    //default in ns
    cl_ulong kernel_time_ns5 = getStartEndTime(write_event[4]);
    printf("Fifth Write to kernel time: %0.3f ms\n", double(kernel_time_ns5) *1e-6 );

    //default in ns
    cl_ulong kernel_time_ns6 = getStartEndTime(write_event[5]);
    printf("Sixth Write to kernel time: %0.3f ms\n", double(kernel_time_ns6) *1e-6 );


    //default in ns
    cl_ulong kernel_time_ns7 = getStartEndTime(write_event[6]);
    printf("Seventh Write to kernel time: %0.3f ms\n", double(kernel_time_ns7) *1e-6 );

    //default in ns
    cl_ulong kernel_time_ns8 = getStartEndTime(write_event[7]);
    printf("Eighth Write to kernel time: %0.3f ms\n", double(kernel_time_ns8) *1e-6 );




/*

    //default in ns
    cl_ulong write_time_ns1 = getStartEndTime(kernel_event[0]);
    printf("First Kernel time: %0.3f ms\n", double(write_time_ns1) *1e-6 );

    //default in ns
    cl_ulong write_time_ns2 = getStartEndTime(kernel_event[1]);
    printf("Second Kernel time: %0.3f ms\n", double(write_time_ns2) *1e-6 );

    //default in ns
    cl_ulong write_time_ns3 = getStartEndTime(kernel_event[2]);
    printf("Third Kernel time: %0.3f ms\n", double(write_time_ns3) *1e-6 );

*/


	for (int j=0;j<=read_counter;j++){
		cl_ulong write_time_ns = getStartEndTime(kernel_event[j]);
		//std::cerr<<j+1<<"th  Kernel time:" << double(write_time_ns3) *1e-6 << std::endl;
   		printf("%d Kernel time: %0.3f ms\n",j+1, double(write_time_ns) *1e-6 );
	}





/*

    //default in ns
    cl_ulong read_time_ns1 = getStartEndTime(finish_event[0]);
    printf("First Write to host time: %0.3f ms\n", double(read_time_ns1) *1e-6 );

    //default in ns
    cl_ulong read_time_ns2 = getStartEndTime(finish_event[1]);
    printf("Second Write to host time: %0.3f ms\n", double(read_time_ns2) *1e-6 );

    //default in ns
    cl_ulong read_time_ns3 = getStartEndTime(finish_event[2]);
    printf("Third Write to host time: %0.3f ms\n", double(read_time_ns3) *1e-6 );

*/

	for (int j=0;j<=read_counter;j++){
		cl_ulong write_time_ns = getStartEndTime(finish_event[j]);
		//std::cerr<<j+1<<"th  Kernel time:" << double(write_time_ns3) *1e-6 << std::endl;
   		printf("%d Write to host time: %0.3f ms\n",j+1, double(write_time_ns) *1e-6 );
	}


//writing the FPGA output to a text file

/*
	//writing inputVertex[0] to a text file

		std::ofstream myfile3;
		myfile3.open("input_normal_fpga_0.txt");
	for(int i=0;i<(320* 240);i++){
		myfile3<<inputNormal[0][i].x<<" "<<inputNormal[0][i].y<<" "<<inputNormal[0][i].z<<std::endl;
	}

	std::cout<<"output write 1 success"<<std::endl;
	myfile3.close();


	//writing inputVertex[1] to a text file

		std::ofstream myfile4;
		myfile4.open("input_normal_fpga_1.txt");
	for(int i=0;i<(160* 120);i++){
		myfile4<<inputNormal[1][i].x<<" "<<inputNormal[1][i].y<<" "<<inputNormal[1][i].z<<std::endl;
	}

	std::cout<<"output write 2 success"<<std::endl;
	myfile4.close();



	//writing inputVertex[2] to a text file

		std::ofstream myfile5;
		myfile5.open("input_normal_fpga_2.txt");
	for(int i=0;i<(80* 60);i++){
		myfile5<<inputNormal[2][i].x<<" "<<inputNormal[2][i].y<<" "<<inputNormal[2][i].z<<std::endl;
	}

	std::cout<<"output write 3 success"<<std::endl;
	myfile5.close();
*/




//writing to a text file
		std::ofstream outfile;
		outfile.open("tracking_result.txt");
	for(int i=0;i<(320* 240);i++){
		outfile<<trackingResult[i].result<<" "<<trackingResult[i].error<<" "<<trackingResult[i].J[0]<<" "<<trackingResult[i].J[1]<<" "<<trackingResult[i].J[2]<<" "<<trackingResult[i].J[3]<<" "<<trackingResult[i].J[4]<<" "<<trackingResult[i].J[5]<<std::endl;
	}

	std::cout<<"output write 1 success"<<std::endl;
	outfile.close();




/////////////////////////////////////////////	end of kernel timing 	/////////////////////////////////////////////////////////////////

  // Free the resources allocated
  cleanup();

  return 0;
}

/////// HELPER FUNCTIONS ///////

bool init() {
  cl_int status;

  if(!setCwdToExeDir()) {
    return false;
  }

  // Get the OpenCL platform.
  platform = findPlatform("Altera");
  if(platform == NULL) {
    printf("ERROR: Unable to find Intel(R) FPGA OpenCL platform.\n");
    return false;
  }

  // User-visible output - Platform information
  {
    char char_buffer[STRING_BUFFER_LEN]; 
    printf("Querying platform for info:\n");
    printf("==========================\n");
    clGetPlatformInfo(platform, CL_PLATFORM_NAME, STRING_BUFFER_LEN, char_buffer, NULL);
    printf("%-40s = %s\n", "CL_PLATFORM_NAME", char_buffer);
    clGetPlatformInfo(platform, CL_PLATFORM_VENDOR, STRING_BUFFER_LEN, char_buffer, NULL);
    printf("%-40s = %s\n", "CL_PLATFORM_VENDOR ", char_buffer);
    clGetPlatformInfo(platform, CL_PLATFORM_VERSION, STRING_BUFFER_LEN, char_buffer, NULL);
    printf("%-40s = %s\n\n", "CL_PLATFORM_VERSION ", char_buffer);
  }

  // Query the available OpenCL devices.
  scoped_array<cl_device_id> devices;
  //cl_uint num_devices;

  devices.reset(getDevices(platform, CL_DEVICE_TYPE_ALL, &num_devices));

  // We'll just use the first device.
  device = devices[0];

  // Display some device information.
  //display_device_info(device);

  // Create the context.
  context = clCreateContext(NULL, 1, &device, &oclContextCallback, NULL, &status);
  checkError(status, "Failed to create context");

  // Create the command queue.
  queue = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
  checkError(status, "Failed to create command queue");

  // Create the program.
  std::string binary_file = getBoardBinaryFile("hello_world", device);
  printf("Using AOCX: %s\n", binary_file.c_str());
  program = createProgramFromBinary(context, binary_file.c_str(), &device, 1);

  // Build the program that was just created.
  status = clBuildProgram(program, 0, NULL, "", NULL, NULL);
  checkError(status, "Failed to build program");

  // Create the kernel - name passed in here must match kernel name in the
  // original CL file, that was compiled into an AOCX file using the AOC tool
  const char *kernel_name = "AOCtrackKernel";  // Kernel name, as defined in the CL file
  kernel = clCreateKernel(program, kernel_name, &status);
  checkError(status, "Failed to create kernel");

  return true;
}

// Free the resources allocated during initialization
void cleanup() {

	cl_int status;

  if(kernel) {
    clReleaseKernel(kernel);  
  }
  if(program) {
    clReleaseProgram(program);
  }
  if(queue) {
    clReleaseCommandQueue(queue);
  }
  if(context) {
    clReleaseContext(context);
  }
////////////////////////



	for (unsigned int i = 0; i < iterations.size(); ++i) {

		  if (ocl_inputVertex[i]) {
		    status = clReleaseMemObject(ocl_inputVertex[i]);
		    checkError(status, "clReleaseMem");
		    ocl_inputVertex[i] = NULL;
		  }

		free(inputVertex[i]);



		  if (ocl_inputNormal[i]) {
		    status = clReleaseMemObject(ocl_inputNormal[i]);
		    checkError(status, "clReleaseMem");
		    ocl_inputNormal[i] = NULL;
		  }
		free(inputNormal[i]);


	}

	if (ocl_inputVertex) {
		free(ocl_inputVertex);
	ocl_inputVertex = NULL;
	}

	free(inputVertex);


	if (ocl_inputNormal) {
		free(ocl_inputNormal);
	ocl_inputNormal = NULL;
	}
	free(inputNormal);

	if (ocl_trackingResult) {
	 status = 	clReleaseMemObject(ocl_trackingResult);
		checkError(status, "clReleaseMem");
	ocl_trackingResult = NULL;
	}
	free(trackingResult);

	if (ocl_vertex) {
	 status = clReleaseMemObject(ocl_vertex);
	checkError(status, "clReleaseMem");
	ocl_vertex = NULL;
	}
	free(vertex);

	if (ocl_normal) {
	   status = clReleaseMemObject(ocl_normal);
	  checkError(status, "clReleaseMem");
	ocl_normal = NULL;
	}
	free(normal);

///////////////////
}

// Helper functions to display parameters returned by OpenCL queries
static void device_info_ulong( cl_device_id device, cl_device_info param, const char* name) {
   cl_ulong a;
   clGetDeviceInfo(device, param, sizeof(cl_ulong), &a, NULL);
   printf("%-40s = %lu\n", name, a);
}
static void device_info_uint( cl_device_id device, cl_device_info param, const char* name) {
   cl_uint a;
   clGetDeviceInfo(device, param, sizeof(cl_uint), &a, NULL);
   printf("%-40s = %u\n", name, a);
}
static void device_info_bool( cl_device_id device, cl_device_info param, const char* name) {
   cl_bool a;
   clGetDeviceInfo(device, param, sizeof(cl_bool), &a, NULL);
   printf("%-40s = %s\n", name, (a?"true":"false"));
}
static void device_info_string( cl_device_id device, cl_device_info param, const char* name) {
   char a[STRING_BUFFER_LEN]; 
   clGetDeviceInfo(device, param, STRING_BUFFER_LEN, &a, NULL);
   printf("%-40s = %s\n", name, a);
}

// Query and display OpenCL information on device and runtime environment
static void display_device_info( cl_device_id device ) {

   printf("Querying device for info:\n");
   printf("========================\n");
   device_info_string(device, CL_DEVICE_NAME, "CL_DEVICE_NAME");
   device_info_string(device, CL_DEVICE_VENDOR, "CL_DEVICE_VENDOR");
   device_info_uint(device, CL_DEVICE_VENDOR_ID, "CL_DEVICE_VENDOR_ID");
   device_info_string(device, CL_DEVICE_VERSION, "CL_DEVICE_VERSION");
   device_info_string(device, CL_DRIVER_VERSION, "CL_DRIVER_VERSION");
   device_info_uint(device, CL_DEVICE_ADDRESS_BITS, "CL_DEVICE_ADDRESS_BITS");
   device_info_bool(device, CL_DEVICE_AVAILABLE, "CL_DEVICE_AVAILABLE");
   device_info_bool(device, CL_DEVICE_ENDIAN_LITTLE, "CL_DEVICE_ENDIAN_LITTLE");
   device_info_ulong(device, CL_DEVICE_GLOBAL_MEM_CACHE_SIZE, "CL_DEVICE_GLOBAL_MEM_CACHE_SIZE");
   device_info_ulong(device, CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE, "CL_DEVICE_GLOBAL_MEM_CACHELINE_SIZE");
   device_info_ulong(device, CL_DEVICE_GLOBAL_MEM_SIZE, "CL_DEVICE_GLOBAL_MEM_SIZE");
   device_info_bool(device, CL_DEVICE_IMAGE_SUPPORT, "CL_DEVICE_IMAGE_SUPPORT");
   device_info_ulong(device, CL_DEVICE_LOCAL_MEM_SIZE, "CL_DEVICE_LOCAL_MEM_SIZE");
   device_info_ulong(device, CL_DEVICE_MAX_CLOCK_FREQUENCY, "CL_DEVICE_MAX_CLOCK_FREQUENCY");
   device_info_ulong(device, CL_DEVICE_MAX_COMPUTE_UNITS, "CL_DEVICE_MAX_COMPUTE_UNITS");
   device_info_ulong(device, CL_DEVICE_MAX_CONSTANT_ARGS, "CL_DEVICE_MAX_CONSTANT_ARGS");
   device_info_ulong(device, CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE, "CL_DEVICE_MAX_CONSTANT_BUFFER_SIZE");
   device_info_uint(device, CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS, "CL_DEVICE_MAX_WORK_ITEM_DIMENSIONS");
   device_info_uint(device, CL_DEVICE_MEM_BASE_ADDR_ALIGN, "CL_DEVICE_MEM_BASE_ADDR_ALIGN");
   device_info_uint(device, CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE, "CL_DEVICE_MIN_DATA_TYPE_ALIGN_SIZE");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_CHAR");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_SHORT");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_INT");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_LONG");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_FLOAT");
   device_info_uint(device, CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE, "CL_DEVICE_PREFERRED_VECTOR_WIDTH_DOUBLE");

   {
      cl_command_queue_properties ccp;
      clGetDeviceInfo(device, CL_DEVICE_QUEUE_PROPERTIES, sizeof(cl_command_queue_properties), &ccp, NULL);
      printf("%-40s = %s\n", "Command queue out of order? ", ((ccp & CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE)?"true":"false"));
      printf("%-40s = %s\n", "Command queue profiling enabled? ", ((ccp & CL_QUEUE_PROFILING_ENABLE)?"true":"false"));
   }
}

