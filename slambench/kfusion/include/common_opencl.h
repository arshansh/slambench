/*

 Copyright (c) 2014 University of Edinburgh, Imperial College, University of Manchester.
 Developed in the PAMELA project, EPSRC Programme Grant EP/K008730/1

 This code is licensed under the MIT License.

 */

#ifndef _COMMON_OPENCL_
#define _COMMON_OPENCL_

#define __NO_STD_VECTOR // Use cl::vector instead of STL version


#include <commons.h>

////////////////////////////
#include "CL/opencl.h"
///////////////////////////////////


/*
// OPEN CL STUFF
extern cl_int clError;
extern cl_platform_id platform_id;
extern cl_event event;
extern cl_device_id device_id;
extern cl_context context;
extern cl_program program;
extern cl_command_queue commandQueue;
*/

//////////////////////////////////

extern cl_int clError;
extern cl_event event;

extern cl_platform_id platform ;
extern cl_device_id device  ;
extern cl_context context ;
extern cl_command_queue queue;
extern cl_kernel kernel ;
extern cl_program program ;
/////////////////////////////////


extern size_t _ls[2];

inline std::string descriptionOfError(cl_int err) {
	switch (err) {
	case CL_SUCCESS:
		return "Success!";
	case CL_DEVICE_NOT_FOUND:
		return "Device not found.";
	case CL_DEVICE_NOT_AVAILABLE:
		return "Device not available";
	case CL_COMPILER_NOT_AVAILABLE:
		return "Compiler not available";
	case CL_MEM_OBJECT_ALLOCATION_FAILURE:
		return "Memory object allocation failure";
	case CL_OUT_OF_RESOURCES:
		return "Out of resources";
	case CL_OUT_OF_HOST_MEMORY:
		return "Out of host memory";
	case CL_PROFILING_INFO_NOT_AVAILABLE:
		return "Profiling information not available";
	case CL_MEM_COPY_OVERLAP:
		return "Memory copy overlap";
	case CL_IMAGE_FORMAT_MISMATCH:
		return "Image format mismatch";
	case CL_IMAGE_FORMAT_NOT_SUPPORTED:
		return "Image format not supported";
	case CL_BUILD_PROGRAM_FAILURE:
		return "Program build failure";
	case CL_MAP_FAILURE:
		return "Map failure";
	case CL_INVALID_VALUE:
		return "Invalid value";
	case CL_INVALID_DEVICE_TYPE:
		return "Invalid device type";
	case CL_INVALID_PLATFORM:
		return "Invalid platform";
	case CL_INVALID_DEVICE:
		return "Invalid device";
	case CL_INVALID_CONTEXT:
		return "Invalid context";
	case CL_INVALID_QUEUE_PROPERTIES:
		return "Invalid queue properties";
	case CL_INVALID_COMMAND_QUEUE:
		return "Invalid command queue";
	case CL_INVALID_HOST_PTR:
		return "Invalid host pointer";
	case CL_INVALID_MEM_OBJECT:
		return "Invalid memory object";
	case CL_INVALID_IMAGE_FORMAT_DESCRIPTOR:
		return "Invalid image format descriptor";
	case CL_INVALID_IMAGE_SIZE:
		return "Invalid image size";
	case CL_INVALID_SAMPLER:
		return "Invalid sampler";
	case CL_INVALID_BINARY:
		return "Invalid binary";
	case CL_INVALID_BUILD_OPTIONS:
		return "Invalid build options";
	case CL_INVALID_PROGRAM:
		return "Invalid program";
	case CL_INVALID_PROGRAM_EXECUTABLE:
		return "Invalid program executable";
	case CL_INVALID_KERNEL_NAME:
		return "Invalid kernel name";
	case CL_INVALID_KERNEL_DEFINITION:
		return "Invalid kernel definition";
	case CL_INVALID_KERNEL:
		return "Invalid kernel";
	case CL_INVALID_ARG_INDEX:
		return "Invalid argument index";
	case CL_INVALID_ARG_VALUE:
		return "Invalid argument value";
	case CL_INVALID_ARG_SIZE:
		return "Invalid argument size";
	case CL_INVALID_KERNEL_ARGS:
		return "Invalid kernel arguments";
	case CL_INVALID_WORK_DIMENSION:
		return "Invalid work dimension";
	case CL_INVALID_WORK_GROUP_SIZE:
		return "Invalid work group size";
	case CL_INVALID_WORK_ITEM_SIZE:
		return "Invalid work item size";
	case CL_INVALID_GLOBAL_OFFSET:
		return "Invalid global offset";
	case CL_INVALID_EVENT_WAIT_LIST:
		return "Invalid event wait list";
	case CL_INVALID_EVENT:
		return "Invalid event";
	case CL_INVALID_OPERATION:
		return "Invalid operation";
	case CL_INVALID_GL_OBJECT:
		return "Invalid OpenGL object";
	case CL_INVALID_BUFFER_SIZE:
		return "Invalid buffer size";
	case CL_INVALID_MIP_LEVEL:
		return "Invalid mip-map level";
	default:
		return "Unknown";
	}
}

#define checkErr(err,name) \
  if (err != CL_SUCCESS) {\
    std::cerr << "ERR: " << std::string(name) << "(";\
    std::cerr << descriptionOfError(err);							\
    std::cerr << ") " << __FILE__ << ":"<< __LINE__ << std::endl;	\
    exit(EXIT_FAILURE);\
  }

inline void checkErrX(cl_int err, const char * name) {
	if (err != CL_SUCCESS) {
		std::cerr << "ERROR: " << name << " (" << err << ")" << std::endl;
		exit(EXIT_FAILURE);
	}
}

void opencl_init(void);
void opencl_clean(void);


#define STRING_BUFFER_LEN 1024
static void device_info_ulong( cl_device_id device, cl_device_info param, const char* name);
static void device_info_uint( cl_device_id device, cl_device_info param, const char* name);
static void device_info_bool( cl_device_id device, cl_device_info param, const char* name);
static void device_info_string( cl_device_id device, cl_device_info param, const char* name);
static void display_device_info( cl_device_id device );

// Host allocation functions
void *alignedMalloc(size_t size);
void alignedFree(void *ptr);

// Error functions
void printError(cl_int error);


// Sets the current working directory to the same directory that contains
// this executable. Returns true on success.
bool setCwdToExeDir();

// Find a platform that contains the search string in its name (case-insensitive match).
// Returns NULL if no match is found.
cl_platform_id findPlatform(const char *platform_name_search);

// Returns the name of the platform.
std::string getPlatformName(cl_platform_id pid);

// Returns the name of the device.
std::string getDeviceName(cl_device_id did);

// Returns an array of device ids for the given platform and the
// device type.
// Return value must be freed with delete[].
cl_device_id *getDevices(cl_platform_id pid, cl_device_type dev_type, cl_uint *num_devices);

// Create a OpenCL program from a binary file.
// The program is created for all given devices associated with the context. The same
// binary is used for all devices.
cl_program createProgramFromBinary(cl_context context, const char *binary_file_name, const cl_device_id *devices, unsigned num_devices);

// Load binary file.
// Return value must be freed with delete[].
unsigned char *loadBinaryFile(const char *file_name, size_t *size);

// Checks if a file exists.
bool fileExists(const char *file_name);

// Returns the path to the AOCX file to use for the given device.
// This is special handling for examples for the Intel(R) FPGA SDK for OpenCL(TM).
// It uses the device name to get the board name and then looks for a
// corresponding AOCX file. Specifically, it gets the device name and
// extracts the board name assuming the device name has the following format:
//  <board> : ...
//
// Then the AOCX file is <prefix>_<version>_<board>.aocx. If this
// file does not exist, then the file name defaults to <prefix>.aocx.
std::string getBoardBinaryFile(const char *prefix, cl_device_id device);

// Returns the time from a high-resolution timer in seconds. This value
// can be used with a value returned previously to measure a high-resolution
// time difference.
double getCurrentTimestamp();

// Returns the difference between the CL_PROFILING_COMMAND_END and
// CL_PROFILING_COMMAND_START values of a cl_event object.
// This requires that the command queue associated with the event be created
// with the CL_QUEUE_PROFILING_ENABLE property.
//
// The return value is in nanoseconds.
cl_ulong getStartEndTime(cl_event event);

// Returns the maximum time span for the given set of events.
// The time span starts at the earliest event start time.
// The time span ends at the latest event end time.
cl_ulong getStartEndTime(cl_event *events, unsigned num_events);

// Wait for the specified number of milliseconds.
void waitMilliseconds(unsigned ms);

// OpenCL context callback function that simply prints the error information
// to stdout (via printf).
void oclContextCallback(const char *errinfo, const void *, size_t, void *);

#define RELEASE_IN_BUFFER(name)  \
    clError = clReleaseMemObject(name##Buffer);\
	checkErr( clError, "clReleaseMemObject");

#define RELEASE_OUT_BUFFER(name) \
    clError = clEnqueueReadBuffer(commandQueue , name##Buffer, CL_TRUE, 0, name##BufferSize, name##Ptr, 0, NULL, NULL );  \
    checkErr( clError, "clEnqueueReadBuffer");\
    clError = clReleaseMemObject(name##Buffer);\
	checkErr( clError, "clReleaseMemObject");

#define RELEASE_INOUT_BUFFER(name)  \
    clError = clEnqueueReadBuffer(commandQueue , name##Buffer, CL_TRUE, 0, name##BufferSize, name##Ptr, 0, NULL, NULL );  \
    checkErr( clError, "clEnqueueReadBuffer");\
    clError = clReleaseMemObject(name##Buffer);\
	checkErr( clError, "clReleaseMemObject");

#define RELEASE_KERNEL(kernelname)      clError = clReleaseKernel(kernelname);  checkErr( clError, "clReleaseKernel");

#define CREATE_KERNEL(name)   CREATE_KERNELVAR(name,#name);
#define CREATE_KERNELVAR(varname,kernelname)   cl_kernel varname = clCreateKernel(program,kernelname, &clError); checkErr( clError, "clCreateKernel" );

#define CREATE_OUT_BUFFER(name,ptr,size)\
    size_t name##BufferSize    =   size;\
    void * name##Ptr           =  (void *) ptr;\
    cl_mem name##Buffer  = clCreateBuffer(context,  CL_MEM_WRITE_ONLY  , name##BufferSize , NULL , &clError);\
    checkErr( clError, "clCreateBuffer input" );

#define CREATE_IN_BUFFER(name,ptr,size)\
    size_t name##BufferSize    =   size;\
    void * name##Ptr           =  (void *) ptr;\
    cl_mem name##Buffer  = clCreateBuffer(context,  CL_MEM_READ_ONLY | CL_MEM_USE_HOST_PTR  , name##BufferSize , name##Ptr , &clError);\
    checkErr( clError, "clCreateBuffer input" );\


#define CREATE_INOUT_BUFFER(name,ptr,size)\
    size_t name##BufferSize    =   size;\
    void * name##Ptr           =  (void *) ptr;\
    cl_mem name##Buffer  = clCreateBuffer(context,  CL_MEM_READ_WRITE  , name##BufferSize , NULL , &clError);\
    checkErr( clError, "clCreateBuffer input" );\
        clError = clEnqueueWriteBuffer(commandQueue, name##Buffer , CL_TRUE, 0, name##BufferSize , ptr, 0, NULL, NULL);\
    checkErr( clError, "clEnqueueWriteBuffer" ) ;

// Remove the CL_TRUE in the write here?

#endif // _COMMON_OPENCL_
