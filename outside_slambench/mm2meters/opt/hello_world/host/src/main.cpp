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




//////////////////////////////////////////// declrations here/////////////////////////////////////


cl_uint num_devices;


//const uint2 outSize = make_uint2(320,240);
//const uint2 inSize = make_uint2(640,480);

const uint outSize_x=320;
const uint outSize_y=240;

const uint inSize_x=640;
const uint inSize_y=480;

const uint computationSizeBkp_x=640;
const uint computationSizeBkp_y=480;

cl_mem ocl_depth_buffer = NULL;
uint16_t* inputDepth;

cl_mem ocl_FloatDepth = NULL;
float * floatDepth;

////////////////////////////////////////////end of declrations here /////////////////////////////////////

// Function prototypes
bool init();
void cleanup();
static void device_info_ulong( cl_device_id device, cl_device_info param, const char* name);
static void device_info_uint( cl_device_id device, cl_device_info param, const char* name);
static void device_info_bool( cl_device_id device, cl_device_info param, const char* name);
static void device_info_string( cl_device_id device, cl_device_info param, const char* name);
static void display_device_info( cl_device_id device );





// Entry point.
int main() {
  cl_int status;

  if(!init()) {
    return -1;
  }

  // Set the kernel argument (argument 0)
  //status = clSetKernelArg(kernel, 0, sizeof(cl_int), (void*)&thread_id_to_output);
  //checkError(status, "Failed to set kernel arg 0");


/////////////////////////////////////////////////	Declare things 	////////////////////////////////////////////////////////////////////////////////


	
	cl_event write_event[1];
	cl_event kernel_event;
	cl_event finish_event;


///mm2meters kernel
	//uint2 outSize = computationSize;

	// Check for unsupported conditions
	if ((inSize_x < outSize_x) || (inSize_y < outSize_y)) {
		std::cerr << "Invalid ratio." << std::endl;
		exit(1);
	}
	if ((inSize_x % outSize_x != 0) || (inSize_y % outSize_y != 0)) {
		std::cerr << "Invalid ratio." << std::endl;
		exit(1);
	}
	if ((inSize_x / outSize_x != inSize_y / outSize_y)) {
		std::cerr << "Invalid ratio." << std::endl;
		exit(1);
	}

	int ratio = inSize_x / outSize_x;



//inputs

	//input depth decleration
	inputDepth = (uint16_t*) malloc(
			sizeof(uint16_t) * inSize_x * inSize_y);

	//ocl_depth_buffer decleration
	if (ocl_depth_buffer != NULL) {
		status = clReleaseMemObject(ocl_depth_buffer);
		checkError(status, "clReleaseMemObject");
	}
	ocl_depth_buffer = clCreateBuffer(context, CL_MEM_READ_WRITE,
			inSize_x * inSize_y * sizeof(uint16_t), NULL, &status);
	checkError(status, "clCreateBuffer input");


//outputs

	//declearing ocl_float depth
	ocl_FloatDepth = clCreateBuffer(context, CL_MEM_READ_WRITE,
	sizeof(float) * outSize_x * outSize_y, NULL,
	&status);
	checkError(status, "clCreateBuffer");

	//declaring floatdepth
	floatDepth = (float*) calloc(
			sizeof(float) * outSize_x * outSize_y, 1);




/////////////////////////////////////////////	end of declare things /////////////////////////////////////////////////////////////////



//read input Depth of frame 0 from a file and store it in inputdepth

	//std::string value;
	std::ifstream myfile ("input_depth.txt");
	
/*
	std::ofstream myfile;
	myfile.open("input_depthsssss.txt");
	for(int i=0;i<2;i++){
		myfile<<"hi"<<std::endl;
		//std::cout<<inputDepth[i]<<std::endl;
	}

*/

/*

	int j=0;
	if(myfile.is_open()){
		while ( std::getline(myfile,value) ){
			//std::istringstream line_stream(value);
			//inputDepth[j]<<line_stream;
			//std::cout<<value<<std::endl;
			inputDepth[j]=std::atoi(value);
			j++;
		}
	}
	else{
		std::cout<<"file can not be opened"<<std::endl;
	}	
*/

	for(int i=0;i<640*480;i++){
		
		myfile>> inputDepth[i];
	}

	std::cout<<"input read success"<<std::endl;
	myfile.close();


	//input write 
	std::ofstream myfile2;
	myfile2.open("input_depth_fpga.txt");
	for(int i=0;i<(640*480);i++){
		myfile2<<inputDepth[i]<<std::endl;
	
	}
	std::cout<<"input write success"<<std::endl;
	myfile2.close();


/////////////////////////////////////////////	building the kernel   /////////////////////////////////////////////////////////////////

	double start_time = getCurrentTimestamp();

	

	//data write from host to kernel memory
	status = clEnqueueWriteBuffer(queue, ocl_depth_buffer, CL_FALSE, 0,inSize_x * inSize_y * sizeof(uint16_t), inputDepth, 0, NULL, &write_event[0]);
	//status = clEnqueueWriteBuffer(queue, ocl_depth_buffer, CL_FALSE, 0,inSize_x * inSize_y * sizeof(uint16_t), inputDepth, 0, NULL, NULL);
	checkError(status, "clEnqueueWriteBuffer");
	

	

	//setting arguments
	int arg = 0;
	status = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
			&ocl_FloatDepth);
	checkError(status, "clSetKernelArg");



	status = clSetKernelArg(kernel, arg++, sizeof(cl_uint),
			&outSize_x);
	checkError(status, "clSetKernelArg");





	status = clSetKernelArg(kernel, arg++, sizeof(cl_mem),
			&ocl_depth_buffer);
	checkError(status, "clSetKernelArg");



	status = clSetKernelArg(kernel, arg++, sizeof(cl_uint),
			&inSize_x );
	checkError(status, "clSetKernelArg");





	status = clSetKernelArg(kernel, arg++, sizeof(cl_int),
			&ratio);
	checkError(status, "clSetKernelArg");

	size_t globalWorksize[2] = { outSize_x, outSize_y };



	  printf("\nKernel initialization is complete.\n");
	  printf("Launching the kernel...\n\n");


	// Launch the kernel
	
	//status = clEnqueueNDRangeKernel(queue, kernel, 2,NULL, globalWorksize, NULL, 1,write_event, &kernel_event);
	status=clEnqueueTask(queue,kernel,1,write_event,&kernel_event);
	//status = clEnqueueNDRangeKernel(queue, kernel, 2,NULL, globalWorksize, NULL,0,NULL,NULL);
	
	checkError(status, "clEnqueueNDRangeKernel");



	//read the data back to host

	//This is done so that floatDepth=ocl_FloatDepth,because they are essentially the same thing and floatDepth get reads in renderDepth function, and next kernel(bilateral filter) , and integrateKernel
	
	status = clEnqueueReadBuffer(queue,ocl_FloatDepth, CL_FALSE, 0,outSize_x * outSize_y * sizeof(float), floatDepth, 1,&kernel_event, &finish_event);
	//status = clEnqueueReadBuffer(queue,ocl_FloatDepth, CL_TRUE, 0,outSize_x * outSize_y * sizeof(float), floatDepth, 0,NULL, NULL);
	
	checkError(status, "clEnqueueReadBuffer");

	





////end of mm2meters kernels




/////////////////////////////////////////////	end of kernel execution /////////////////////////////////////////////////////////////////


/////////////////////////////////////////////	timing the kernel /////////////////////////////////////////////////////////////////


  // Wait for command queue to complete pending events
  status = clFinish(queue);
  checkError(status, "Failed to finish");

  // Wait for all devices to finish.
  clWaitForEvents(num_devices, &finish_event);

  double end_time = getCurrentTimestamp();

  printf("\nKernel execution is complete.\n");

  // Wall-clock time taken.(seconds by default)
  printf("\nTime: %0.3f ms\n", (end_time - start_time) * 1e3);



    //default in ns
    cl_ulong kernel_time_ns = getStartEndTime(write_event[0]);
    printf("Write to kernel time: %0.3f ms\n", double(kernel_time_ns) *1e-6 );

    //default in ns
    cl_ulong write_time_ns = getStartEndTime(kernel_event);
    printf("Kernel time: %0.3f ms\n", double(write_time_ns) *1e-6 );


    //default in ns
    cl_ulong read_time_ns = getStartEndTime(finish_event);
    printf("Write to host time: %0.3f ms\n", double(read_time_ns) *1e-6 );



//writing the FPGA output to a text file

	std::ofstream myfile1;
	myfile1.open("float_depth_fpga.txt");
	for(int i=0;i<(320*240);i++){
		myfile1<<floatDepth[i]<<std::endl;
	
	}
	std::cout<<"output write success"<<std::endl;
	myfile1.close();
	

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
  const char *kernel_name = "AOCmm2metersKernel";  // Kernel name, as defined in the CL file
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


   if (ocl_depth_buffer){
     clReleaseMemObject(ocl_depth_buffer);
     ocl_depth_buffer = NULL;
   }

   free(inputDepth);

  if (ocl_FloatDepth){
    clReleaseMemObject(ocl_FloatDepth);
    ocl_FloatDepth = NULL;
  }

  free(floatDepth);


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

