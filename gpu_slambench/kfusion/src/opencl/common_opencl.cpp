/*

 Copyright (c) 2014 University of Edinburgh, Imperial College, University of Manchester.
 Developed in the PAMELA project, EPSRC Programme Grant EP/K008730/1

 This code is licensed under the MIT License.

 */

#define EXTERNS
#include "common_opencl.h"
#include <sstream>


////////////////////////////////////
#include "CL/opencl.h"
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cstring>
#include <unistd.h> // readlink, chdir
#include <algorithm>
#include <stdarg.h>
///////////////////////////////////


#define STRING_BUFFER_LEN 1024

////////////////////////////////////////////////
/*
using namespace aocl_utils;
#define STRING_BUFFER_LEN 1024
static void device_info_ulong( cl_device_id device, cl_device_info param, const char* name);
static void device_info_uint( cl_device_id device, cl_device_info param, const char* name);
static void device_info_bool( cl_device_id device, cl_device_info param, const char* name);
static void device_info_string( cl_device_id device, cl_device_info param, const char* name);
static void display_device_info( cl_device_id device );
*/
/////////////////////////////////////////////////


// OPEN CL STUFF
cl_int clError = CL_SUCCESS;
cl_platform_id platform = 0;
cl_device_id device=NULL;             // compute device id 
cl_context context=NULL;
cl_program program=NULL;
cl_command_queue commandQueue;
cl_event event=NULL;
//////////////////////////////////////

void opencl_clean(void) {

	clReleaseContext(context);
	clReleaseCommandQueue(commandQueue);
	clReleaseProgram(program);

	return;
}


////////////////////////////////////////////////////////////////////////////

/*
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

*/
////////////////////////////////////////////////////////////////////////////////


void opencl_init(void) {


///////////////////////////////
/*

	cl_int status;

	if(!setCwdToExeDir()) {
	return;
	}

	// Get the OpenCL platform.
	platform = findPlatform("Intel(R) FPGA");
	if(platform == NULL) {
	printf("ERROR: Unable to find Intel(R) FPGA OpenCL platform.\n");
	return;
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
	cl_uint num_devices;

	devices.reset(getDevices(platform, CL_DEVICE_TYPE_ALL, &num_devices));

	// We'll just use the first device.
	device = devices[0];

	// Display some device information.
	display_device_info(device);

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
	const char *kernel_name = "hello_world";  // Kernel name, as defined in the CL file
	kernel = clCreateKernel(program, kernel_name, &status);
	checkError(status, "Failed to create kernel");

	return;
*/
//////////////////////////////////////////////////

	// get the platform

	cl_uint num_platforms;
	clError = clGetPlatformIDs(0, NULL, &num_platforms);
	//std::cout<<"hiiiiiiii"<<clError<<std::endl;
	//std::cout<<"no platforms="<<num_platforms<<std::endl;
	checkErr(clError, "clGetPlatformIDs( 0, NULL, &num_platforms );");
	//std::cout<<num_platforms<<std::endl;
	if (num_platforms <= 0) {
		std::cout << "No platform..." << std::endl;
		exit(1);
	}

	cl_platform_id* platforms = new cl_platform_id[num_platforms];
	clError = clGetPlatformIDs(num_platforms, platforms, NULL);
	checkErr(clError, "clGetPlatformIDs( num_platforms, &platforms, NULL );");

	if (num_platforms > 1) {
		char platformName[256];
		clError = clGetPlatformInfo(platforms[0], CL_PLATFORM_VENDOR,
				sizeof(platformName), platformName, NULL);
		std::cerr << "Multiple platforms found defaulting to: " << platformName
				<< std::endl;
	}
	platform = platforms[0];
	if (getenv("OPENCL_PLATEFORM"))
		platform = platforms[1];
	delete platforms;

///////////////////////
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
////////////////////////


	// Connect to a compute device
	//
	cl_uint device_count = 0;
	clError = clGetDeviceIDs(platform, CL_DEVICE_TYPE_ALL, 0, NULL,
			&device_count);
	checkErr(clError, "Failed to create a device group");
	cl_device_id* deviceIds = (cl_device_id*) malloc(
			sizeof(cl_device_id) * device_count);
	clError = clGetDeviceIDs(platform, CL_DEVICE_TYPE_ALL, device_count,
			deviceIds, NULL);
	
	if (device_count > 1) {
		char device_name[256];
		int compute_units;
		clError = clGetDeviceInfo(deviceIds[0], CL_DEVICE_NAME,
				sizeof(device_name), device_name, NULL);
		checkErr(clError, "clGetDeviceInfo failed");
		clError = clGetDeviceInfo(deviceIds[0], CL_DEVICE_MAX_COMPUTE_UNITS,
				sizeof(cl_uint), &compute_units, NULL);
		checkErr(clError, "clGetDeviceInfo failed");
		std::cerr << "Multiple devices found defaulting to: " << device_name;
		std::cerr << " with " << compute_units << " compute units" << std::endl;
	}
	device = deviceIds[0];
	delete deviceIds;
	// Create a compute context 
	//
	context = clCreateContext(0, 1, &device, NULL, NULL, &clError);
	checkErr(clError, "Failed to create a compute context!");

	// Create a command commands
	//
    #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
	commandQueue = clCreateCommandQueue(context, device, 0, &clError);
	checkErr(clError, "Failed to create a command commands!");

	// READ KERNEL FILENAME
	std::string filename = "NOTDEFINED.cl";
	char const* tmp_name = getenv("OPENCL_KERNEL");
	if (tmp_name) {
		filename = std::string(tmp_name);
	} else {
		filename = std::string(__FILE__);
		filename = filename.substr(0, filename.length() - 17);
		filename += "/kernels.cl";

	}

	// READ OPENCL_PARAMETERS
	std::string compile_parameters = "";
	char const* tmp_params = getenv("OPENCL_PARAMETERS");
	if (tmp_params) {
		compile_parameters = std::string(tmp_params);
	}

	std::ifstream kernelFile(filename.c_str(), std::ios::in);

	if (!kernelFile.is_open()) {
		std::cout << "Unable to open " << filename << ". " << __FILE__ << ":"
				<< __LINE__ << "Please set OPENCL_KERNEL" << std::endl;
		exit(1);
	}

	 //*
	 //* Read the kernel file into an output stream.
	 //* Convert this into a char array for passing to OpenCL.
	 //
	std::ostringstream outputStringStream;
	outputStringStream << kernelFile.rdbuf();
	std::string srcStdStr = outputStringStream.str();
	const char* charSource = srcStdStr.c_str();

	kernelFile.close();
	// Create the compute program from the source buffer
	//
	program = clCreateProgramWithSource(context, 1, (const char **) &charSource,
			NULL, &clError);
	if (!program) {
		printf("Error: Failed to create compute program!\n");
		exit(1);
	}

	// Build the program executable
	//
	clError = clBuildProgram(program, 0, NULL, compile_parameters.c_str(), NULL,
			NULL);

	// Get the size of the build log. 
	size_t logSize = 0;
	clGetProgramBuildInfo(program, device, CL_PROGRAM_BUILD_LOG, 0, NULL,
			&logSize);

	if (clError != CL_SUCCESS) {
		if (logSize > 1) {
			char* log = new char[logSize];
			clGetProgramBuildInfo(program, device, CL_PROGRAM_BUILD_LOG,
					logSize, log, NULL);

			std::string stringChars(log, logSize);
			std::cerr << "Build log:\n " << stringChars << std::endl;

			delete[] log;
		}
		printf("Error: Failed to build program executable!\n");
		exit(1);
	}

	return;



}
