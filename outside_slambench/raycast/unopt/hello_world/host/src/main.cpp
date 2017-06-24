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



// OpenCL runtime configuration
static cl_platform_id platform = NULL;
static cl_device_id device = NULL;
static cl_context context = NULL;
static cl_command_queue queue = NULL;
static cl_kernel kernel = NULL;
static cl_program program = NULL;

///////
cl_uint num_devices;



struct TrackData {
	int result;
	float error;
	float J[6];
};

typedef struct __attribute__ ((packed)) sMatrix4 {
	cl_float4 data[4];
} Matrix4;


////////
////////////////////////////////////////////



cl_mem ocl_trackingResult = NULL;
TrackData * trackingResult;

cl_mem ocl_reduce_output_buffer = NULL;
float * reduceOutputBuffer = NULL;

cl_mem ocl_volume_data = NULL;
short2 * volume_data_integrate;


cl_mem ocl_FloatDepth = NULL;
float * floatDepth;

cl_mem ocl_vertex = NULL;
float3 * vertex;

cl_mem ocl_normal = NULL;
float3 * normal;


cl_mem k_buffer;
cl_mem inv_buffer;


cl_mem view_buffer;





//const uint computationSize.x=320;
//const uint computationSize.y=240;
uint2 computationSize = make_uint2(320,240);



const uint outSize_x=320;
const uint outSize_y=240;

uint3 volumeResolution=make_uint3(256,256,256);


float3 volumeDimensions=make_float3(4.800000191, 4.800000191 ,4.800000191);






//uint iterations.size()=3;
std::vector<int> iterations;  // max number of iterations per level


static const size_t number_of_groups = 8;
static const size_t size_of_group = 64;


const int radius = 2;

const float e_delta = 0.1f;
const float dist_threshold = 0.1f;
const float normal_threshold = 0.8f;

const float maxweight = 100.0f;
const float nearPlane = 0.4f;
const float farPlane = 4.0f;
const float delta = 4.0f;
float mu=0.1000000015;
float step=0.01875000075;


// Function prototypes
bool init();
void cleanup();
static void device_info_ulong( cl_device_id device, cl_device_info param, const char* name);
static void device_info_uint( cl_device_id device, cl_device_info param, const char* name);
static void device_info_bool( cl_device_id device, cl_device_info param, const char* name);
static void device_info_string( cl_device_id device, cl_device_info param, const char* name);
static void display_device_info( cl_device_id device );


//functions needed





// Entry point.
int main() {
  cl_int status;

  if(!init()) {
    return -1;
  }


/////////////////////////////////////////////////	Declare things 	////////////////////////////////////////////////////////////////////////////////



	cl_event write_event[3];
	cl_event kernel_event[1];
	cl_event finish_event[3];

	float largestep = mu * 0.75f;

	//ocl_volume_data
	ocl_volume_data = clCreateBuffer(context, CL_MEM_READ_WRITE,
			sizeof(short2) * volumeResolution.x * volumeResolution.y
					* volumeResolution.z,
			NULL, &status);
	checkError(status, "clCreateBuffer");

	//volume data
	volume_data_integrate = (short2*) malloc(
			volumeResolution.x * volumeResolution.y * volumeResolution.z
					* sizeof(short2));

	//declearing ocl_float depth
	ocl_FloatDepth = clCreateBuffer(context, CL_MEM_READ_WRITE,
	sizeof(float) * outSize_x * outSize_y, NULL,
	&status);
	checkError(status, "clCreateBuffer");

	
	//float depth decleration
	floatDepth = (float*) calloc(
			sizeof(float) * outSize_x * outSize_y, 1);

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

			
	std::string filename= "normal_read";
	filename+=".txt";
	std::ifstream myfile(filename.c_str());
	for(int i=0;i<computationSize.x * computationSize.y;i++){
		myfile>>normal[i].x>>normal[i].y>>normal[i].z;
	}

	std::cout<<"input read 1 success"<<std::endl;
	myfile.close();



	//read from a file

			
	std::string filename1= "volume_data_read";
	filename1+=".txt";
	std::ifstream myfile1(filename1.c_str());
	for(int i=0;i<volumeResolution.x * volumeResolution.y*volumeResolution.z;i++){
		myfile1>>volume_data_integrate[i].x>>volume_data_integrate[i].y;
	}

	std::cout<<"input read 2 success"<<std::endl;
	myfile1.close();



	std::string filename2= "vertex_read";
	filename2+=".txt";
	std::ifstream myfile2(filename2.c_str());
	for(int i=0;i<computationSize.x * computationSize.y;i++){
		myfile2>>vertex[i].x>>vertex[i].y>>vertex[i].z;
	}

	std::cout<<"input read 3 success"<<std::endl;
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




	//data write from host to kernel memory


	//to device

	status = clEnqueueWriteBuffer(queue,ocl_normal, CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(float3), normal, 0, NULL, &write_event[0]);
	checkError(status, "clEnqueueReadBuffer");


	status = clEnqueueWriteBuffer(queue,ocl_vertex, CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(float3), vertex, 0, NULL, &write_event[1]);
	checkError(status, "clEnqueueReadBuffer");

	status = clEnqueueWriteBuffer(queue,
			ocl_volume_data, CL_TRUE, 0,
			 volumeResolution.x * volumeResolution.y
				* volumeResolution.z * sizeof(short2), volume_data_integrate, 0,
			NULL, &write_event[2]);




	




	//building manually
	Matrix4 view;

	float view_arr[16]={0.004156275652 ,0, -0.6650041342 ,1.632000089,0,0.004166666884 ,-0.5,2.400000095,0, 0 ,1, 1.15200007,0 ,0 ,0 ,1};

	int r=0;
	int t=-1;
	while(r<4){
		view.data[r].x=view_arr[++t];
		view.data[r].y=view_arr[++t];
		view.data[r].z=view_arr[++t];
		view.data[r].w=view_arr[++t];	
		r++;
	}

	view_buffer=clCreateBuffer(context, CL_MEM_READ_ONLY,sizeof(Matrix4),NULL,NULL);
	status = clEnqueueWriteBuffer(queue,view_buffer, CL_TRUE, 0, sizeof(Matrix4), &view, 0, NULL, NULL);
	checkError(status, "clEnqueueReadBuffer");

	clFinish(queue);

	// set param and run kernel
	status = clSetKernelArg(kernel, 0, sizeof(cl_mem),
			(void*) &ocl_vertex);
	checkError(status, "clSetKernelArg0");
	status = clSetKernelArg(kernel, 1, sizeof(cl_mem),
			(void*) &ocl_normal);
	checkError(status, "clSetKernelArg1");
	status = clSetKernelArg(kernel, 2, sizeof(cl_mem),
			(void*) &ocl_volume_data);
	checkError(status, "clSetKernelArg2");
	status = clSetKernelArg(kernel, 3, sizeof(cl_uint3),
			(void*) &volumeResolution);
	checkError(status, "clSetKernelArg3");
	status = clSetKernelArg(kernel, 4, sizeof(cl_float3),
			(void*) &volumeDimensions);
	checkError(status, "clSetKernelArg4");
	status = clSetKernelArg(kernel, 5, sizeof(cl_mem),
			(void*) &view_buffer);
	checkError(status, "clSetKernelArg5");
	status = clSetKernelArg(kernel, 6, sizeof(cl_float),
			(void*) &nearPlane);
	checkError(status, "clSetKernelArg6");
	status = clSetKernelArg(kernel, 7, sizeof(cl_float),
			(void*) &farPlane);
	checkError(status, "clSetKernelArg7");
	status = clSetKernelArg(kernel, 8, sizeof(cl_float),
			(void*) &step);
	checkError(status, "clSetKernelArg8");
	status = clSetKernelArg(kernel, 9, sizeof(cl_float),
			(void*) &largestep);
	checkError(status, "clSetKernelArg9");

	size_t RaycastglobalWorksize[2] =
			{ computationSize.x, computationSize.y };

	status = clEnqueueNDRangeKernel(queue, kernel, 2,
			NULL, RaycastglobalWorksize, NULL, 0, NULL, &kernel_event[0]);
		checkError(status, "clEnqueueNDRangeKernel");


	clFinish(queue);



	////////////	read data back from kernel 
	status = clEnqueueReadBuffer(queue,
			ocl_volume_data, CL_TRUE, 0,
			 volumeResolution.x * volumeResolution.y
				* volumeResolution.z * sizeof(short2), volume_data_integrate, 0,
			NULL, &finish_event[0]);
	checkError(status, "clEnqueueReadBuffer");


	status = clEnqueueReadBuffer(queue,ocl_normal, CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(float3), normal, 0, NULL, &finish_event[1]);
	checkError(status, "clEnqueueReadBuffer");

	status = clEnqueueReadBuffer(queue,ocl_vertex, CL_TRUE, 0,computationSize.x * computationSize.y * sizeof(float3), vertex, 0, NULL, &finish_event[2]);
	checkError(status, "clEnqueueReadBuffer");


	clFinish(queue);


	//writing to a text file
	//writing the FPGA output to a text file


	std::string filename3= "volume_data_write";
	filename3+=".txt";
	std::ofstream myfile3(filename3.c_str());
	for(int i=0;i<volumeResolution.x * volumeResolution.y;i++){
		myfile3<<volume_data_integrate[i].x<<" "<<volume_data_integrate[i].y<<std::endl;
	}

	std::cout<<"output write 1 success"<<std::endl;
	myfile3.close();




	
	std::string filename4= "normal_write";
	filename4+=".txt";
	std::ofstream myfile4(filename4.c_str());
	for(int i=0;i< computationSize.x * computationSize.y;i++){
		myfile4<<normal[i].x<<" "<<normal[i].y<<" "<<normal[i].z<<std::endl;
	}

	std::cout<<"output write 2 success"<<std::endl;
	myfile4.close();



	std::string filename5= "vertex_write";
	filename5+=".txt";
	std::ofstream myfile5(filename5.c_str());
	for(int i=0;i< computationSize.x * computationSize.y;i++){
		myfile5<<vertex[i].x<<" "<<vertex[i].y<<" "<<vertex[i].z<<std::endl;
	}

	std::cout<<"output write 3 success"<<std::endl;
	myfile5.close();







/////////////////////////////////////////////	end of kernel execution /////////////////////////////////////////////////////////////////


/////////////////////////////////////////////	timing the kernel /////////////////////////////////////////////////////////////////




  // Wait for command queue to complete pending events
  status = clFinish(queue);
  checkError(status, "Failed to finish");

  // Wait for all devices to finish.
  clWaitForEvents(num_devices, &finish_event[0]);
 double end_time = getCurrentTimestamp();

  printf("\nKernel execution is complete.\n");

  // Wall-clock time taken.(seconds by default)
  printf("\nTime: %0.3f ms\n", (end_time - start_time) * 1e3);



    //default in ns
    cl_ulong write_time_ns1 = getStartEndTime(write_event[0]);
    printf("First Write to kernel time: %0.3f ms\n", double(write_time_ns1) *1e-6 );
    //default in ns
    cl_ulong write_time_ns2 = getStartEndTime(write_event[1]);
    printf("First Write to kernel time: %0.3f ms\n", double(write_time_ns2) *1e-6 );
    //default in ns
    cl_ulong write_time_ns3 = getStartEndTime(write_event[2]);
    printf("First Write to kernel time: %0.3f ms\n", double(write_time_ns3) *1e-6 );





	cl_ulong kernel_time_ns1 = getStartEndTime(kernel_event[0]);
	printf("Kernel time: %0.3f ms\n", double(write_time_ns1) *1e-6 );



	cl_ulong read_time_ns1 = getStartEndTime(finish_event[0]);
	printf("Write to host time: %0.3f ms\n", double(read_time_ns1) *1e-6 );

	cl_ulong read_time_ns2 = getStartEndTime(finish_event[1]);
	printf("Write to host time: %0.3f ms\n", double(read_time_ns2) *1e-6 );

	cl_ulong read_time_ns3 = getStartEndTime(finish_event[2]);
	printf("Write to host time: %0.3f ms\n", double(read_time_ns3) *1e-6 );
	





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
  const char *kernel_name = "AOCraycastKernel";  // Kernel name, as defined in the CL file
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

	if (ocl_volume_data) {
	 status = 	clReleaseMemObject(ocl_volume_data);
		checkError(status, "clReleaseMem");
	ocl_volume_data = NULL;
	}
	free(volume_data_integrate);

	if (ocl_trackingResult) {
	 status = 	clReleaseMemObject(ocl_trackingResult);
		checkError(status, "clReleaseMem");
	ocl_trackingResult = NULL;
	}
	free(trackingResult);




	if (ocl_reduce_output_buffer) {
	 status = 	clReleaseMemObject(ocl_reduce_output_buffer);
		checkError(status, "clReleaseMem");
	ocl_reduce_output_buffer = NULL;
	}


	if (reduceOutputBuffer)
		free(reduceOutputBuffer);
	reduceOutputBuffer = NULL;




	if (ocl_FloatDepth){
	clReleaseMemObject(ocl_FloatDepth);
	ocl_FloatDepth = NULL;
	}
	free(floatDepth);

	if (inv_buffer){
	clReleaseMemObject(inv_buffer);
	inv_buffer = NULL;
	}


	if (k_buffer){
	clReleaseMemObject(k_buffer);
	k_buffer = NULL;
	}

	if (view_buffer){
	clReleaseMemObject(view_buffer);
	view_buffer = NULL;
	}

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

