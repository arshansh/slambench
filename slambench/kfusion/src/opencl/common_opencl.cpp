/*

 Copyright (c) 2014 University of Edinburgh, Imperial College, University of Manchester.
 Developed in the PAMELA project, EPSRC Programme Grant EP/K008730/1

 This code is licensed under the MIT License.

 */

#define EXTERNS

#include "common_opencl.h"
#include <sstream>


////////////////////////////////////
#include "scoped_ptrs.h"
#include "CL/opencl.h"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cstring>
#include <unistd.h> // readlink, chdir
#include <algorithm>
#include <stdarg.h>
#include <chrono>

using namespace aocl_utils;
///////////////////////////////////




////////////////////////////////////////////////



/////////////////////////////////////////////////

/*
// OPEN CL STUFF
cl_int clError = CL_SUCCESS;
cl_platform_id platform_id = 0;
cl_device_id device_id;             // compute device id 
cl_context context;
cl_program program;
cl_command_queue commandQueue;
*/

// OpenCL runtime configuration
cl_int clError = CL_SUCCESS;
cl_platform_id platform=0;
cl_device_id device = NULL;
cl_context context = NULL;
cl_command_queue queue = NULL;

cl_kernel kernel = NULL;



cl_program program = NULL;
cl_event event=NULL;



static const char *const VERSION_STR = "161";

//////////////////////////////////////////
// Host allocation functions for alignment
//////////////////////////////////////////

// This is the minimum alignment requirement to ensure DMA can be used.
const unsigned AOCL_ALIGNMENT = 64;

#ifdef _WIN32 // Windows
void *alignedMalloc(size_t size) {
  return _aligned_malloc (size, AOCL_ALIGNMENT);
}

void alignedFree(void * ptr) {
  _aligned_free(ptr);
}
#else          // Linux
void *alignedMalloc(size_t size) {
  void *result = NULL;
  int rc;
  rc = posix_memalign (&result, AOCL_ALIGNMENT, size);
  return result;
}

void alignedFree(void * ptr) {
  free (ptr);
}
#endif

//////////////////////////////////////

void opencl_clean(void) {

	clReleaseContext(context);
	clReleaseCommandQueue(queue);
	clReleaseProgram(program);

	return;
}


////////////////////////////////////////////////////////////////////////////


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


////////////////////////////////////////////////////////////////////////////////


// Sets the current working directory to be the same as the directory
// containing the running executable.
bool setCwdToExeDir() {
#ifdef _WIN32 // Windows
  HMODULE hMod = GetModuleHandle(NULL);
  char path[MAX_PATH];
  GetModuleFileNameA(hMod, path, MAX_PATH);

#else         // Linux
  // Get path of executable.
  char path[300];
  ssize_t n = readlink("/proc/self/exe", path, sizeof(path)/sizeof(path[0]) - 1);
  if(n == -1) {
    return false;
  }
  path[n] = 0;
#endif

  // Find the last '\' or '/' and terminate the path there; it is now
  // the directory containing the executable.
  size_t i;
  for(i = strlen(path) - 1; i > 0 && path[i] != '/' && path[i] != '\\'; --i);
  path[i] = '\0';

  // Change the current directory.
#ifdef _WIN32 // Windows
  SetCurrentDirectoryA(path);
#else         // Linux
  int rc;
  rc = chdir(path);
#endif

  return true;
}

// Searches all platforms for the first platform whose name
// contains the search string (case-insensitive).
cl_platform_id findPlatform(const char *platform_name_search) {
  cl_int status;

  std::string search = platform_name_search;
  std::transform(search.begin(), search.end(), search.begin(), tolower);

  // Get number of platforms.
  cl_uint num_platforms;
  status = clGetPlatformIDs(0, NULL, &num_platforms);
  checkErr(status, "Query for number of platforms failed");

  // Get a list of all platform ids.
  scoped_array<cl_platform_id> pids(num_platforms);
  status = clGetPlatformIDs(num_platforms, pids, NULL);
  checkErr(status, "Query for all platform ids failed");

  // For each platform, get name and compare against the search string.
  for(unsigned i = 0; i < num_platforms; ++i) {
    std::string name = getPlatformName(pids[i]);


//////////////////////////
	std::cout<<"name:"<<name<<std::endl;
/////////////////////////

    // Convert to lower case.
    std::transform(name.begin(), name.end(), name.begin(), tolower);

    if(name.find(search) != std::string::npos) {
      // Found!
      return pids[i];
    }
  }

  // No platform found.
  return NULL;
}

// Returns the platform name.
std::string getPlatformName(cl_platform_id pid) {
  cl_int status;

  size_t sz;
  status = clGetPlatformInfo(pid, CL_PLATFORM_NAME, 0, NULL, &sz);
  checkErr(status, "Query for platform name size failed");

  scoped_array<char> name(sz);
  status = clGetPlatformInfo(pid, CL_PLATFORM_NAME, sz, name, NULL);
  checkErr(status, "Query for platform name failed");

  return name.get();
}

// Returns the device name.
std::string getDeviceName(cl_device_id did) {
  cl_int status;

  size_t sz;
  status = clGetDeviceInfo(did, CL_DEVICE_NAME, 0, NULL, &sz);
  checkErr(status, "Failed to get device name size");

  scoped_array<char> name(sz);
  status = clGetDeviceInfo(did, CL_DEVICE_NAME, sz, name, NULL);
  checkErr(status, "Failed to get device name");

  return name.get();
}

// Returns the list of all devices.
cl_device_id *getDevices(cl_platform_id pid, cl_device_type dev_type, cl_uint *num_devices) {
  cl_int status;

  status = clGetDeviceIDs(pid, dev_type, 0, NULL, num_devices);
  checkErr(status, "Query for number of devices failed");

  cl_device_id *dids = new cl_device_id[*num_devices];
  status = clGetDeviceIDs(pid, dev_type, *num_devices, dids, NULL);
  checkErr(status, "Query for device ids");

  return dids;
}

// Create a program for all devices associated with the context.
cl_program createProgramFromBinary(cl_context context, const char *binary_file_name, const cl_device_id *devices, unsigned num_devices) {
  // Early exit for potentially the most common way to fail: AOCX does not exist.
  if(!fileExists(binary_file_name)) {
    printf("AOCX file '%s' does not exist.\n", binary_file_name);
    checkErr(CL_INVALID_PROGRAM, "Failed to load binary file");
  }

  // Load the binary.
  size_t binary_size;
  scoped_array<unsigned char> binary(loadBinaryFile(binary_file_name, &binary_size));
  if(binary == NULL) {
    checkErr(CL_INVALID_PROGRAM, "Failed to load binary file");
  }

  scoped_array<size_t> binary_lengths(num_devices);
  scoped_array<unsigned char *> binaries(num_devices);
  for(unsigned i = 0; i < num_devices; ++i) {
    binary_lengths[i] = binary_size;
    binaries[i] = binary;
  }

  cl_int status;
  scoped_array<cl_int> binary_status(num_devices);

  cl_program program = clCreateProgramWithBinary(context, num_devices, devices, binary_lengths,
      (const unsigned char **) binaries.get(), binary_status, &status);
  checkErr(status, "Failed to create program with binary");
  for(unsigned i = 0; i < num_devices; ++i) {
    checkErr(binary_status[i], "Failed to load binary for device");
  }

  return program;
}

// Loads a file in binary form.
unsigned char *loadBinaryFile(const char *file_name, size_t *size) {
  // Open the File
  FILE* fp;
#ifdef _WIN32
  if(fopen_s(&fp, file_name, "rb") != 0) {
    return NULL;
  }
#else
  fp = fopen(file_name, "rb");
  if(fp == 0) {
    return NULL;
  }
#endif

  // Get the size of the file
  fseek(fp, 0, SEEK_END);
  *size = ftell(fp);

  // Allocate space for the binary
  unsigned char *binary = new unsigned char[*size];

  // Go back to the file start
  rewind(fp);

  // Read the file into the binary
  if(fread((void*)binary, *size, 1, fp) == 0) {
    delete[] binary;
    fclose(fp);
    return NULL;
  }

  return binary;
}

bool fileExists(const char *file_name) {
#ifdef _WIN32 // Windows
  DWORD attrib = GetFileAttributesA(file_name);
  return (attrib != INVALID_FILE_ATTRIBUTES && !(attrib & FILE_ATTRIBUTE_DIRECTORY));
#else         // Linux
  return access(file_name, R_OK) != -1;
#endif
}

std::string getBoardBinaryFile(const char *prefix, cl_device_id device) {
  // First check if <prefix>.aocx exists. Use it if it does.
  std::string file_name = std::string(prefix) + ".aocx";
  if(fileExists(file_name.c_str())) {
    return file_name;
  }

  // Now get the name of the board. For Intel(R) FPGA SDK for OpenCL(TM) boards,
  // the name of the device is presented as:
  //  <board name> : ...
  std::string device_name = getDeviceName(device);

  // Now search for the " :" in the device name.
  size_t end = device_name.find(" :");
  if(end != std::string::npos) {
    std::string board_name(device_name, 0, end);

    // Look for a AOCX with the name <prefix>_<board_name>_<version>.aocx.
    file_name = std::string(prefix) + "_" + board_name + "_" + VERSION_STR + ".aocx";
    if(fileExists(file_name.c_str())) {
      return file_name;
    }
  }

  // At this point just use <prefix>.aocx. This file doesn't exist
  // and this should trigger an error later.
  return std::string(prefix) + ".aocx";
}

// High-resolution timer.
double getCurrentTimestamp() {
#ifdef _WIN32 // Windows
  // Use the high-resolution performance counter.

  static LARGE_INTEGER ticks_per_second = {};
  if(ticks_per_second.QuadPart == 0) {
    // First call - get the frequency.
    QueryPerformanceFrequency(&ticks_per_second);
  }

  LARGE_INTEGER counter;
  QueryPerformanceCounter(&counter);

  double seconds = double(counter.QuadPart) / double(ticks_per_second.QuadPart);
  return seconds;
#else         // Linux
  timespec a;
  clock_gettime(CLOCK_MONOTONIC, &a);
  return (double(a.tv_nsec) * 1.0e-9) + double(a.tv_sec);
#endif
}

cl_ulong getStartEndTime(cl_event event) {
  cl_int status;

  cl_ulong start, end;
  status = clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_START, sizeof(start), &start, NULL);
  checkErr(status, "Failed to query event start time");
  status = clGetEventProfilingInfo(event, CL_PROFILING_COMMAND_END, sizeof(end), &end, NULL);
  checkErr(status, "Failed to query event end time");

  return end - start;
}

cl_ulong getStartEndTime(cl_event *events, unsigned num_events) {
  cl_int status;

  cl_ulong min_start = 0;
  cl_ulong max_end = 0;
  for(unsigned i = 0; i < num_events; ++i) {
    cl_ulong start, end;
    status = clGetEventProfilingInfo(events[i], CL_PROFILING_COMMAND_START, sizeof(start), &start, NULL);
    checkErr(status, "Failed to query event start time");
    status = clGetEventProfilingInfo(events[i], CL_PROFILING_COMMAND_END, sizeof(end), &end, NULL);
    checkErr(status, "Failed to query event end time");

    if(i == 0) {
      min_start = start;
      max_end = end;
    }
    else {
      if(start < min_start) {
        min_start = start;
      }
      if(end > max_end) {
        max_end = end;
      }
    }
  }

  return max_end - min_start;
}

void waitMilliseconds(unsigned ms) {
#ifdef _WIN32 // Windows
  Sleep(ms);
#else         // Linux
  timespec sleeptime = {0, 0};
  sleeptime.tv_sec = ms / 1000;
  sleeptime.tv_nsec = long(ms % 1000) * 1000000L;  // convert to nanoseconds
  nanosleep(&sleeptime, NULL);
#endif
}

void oclContextCallback(const char *errinfo, const void *, size_t, void *) {
  printf("Context callback: %s\n", errinfo);
}




void opencl_init(void) {


///////////////////////////////


	cl_int status;

	if(!setCwdToExeDir()) {
	return;
	}

	// Get the OpenCL platform.
	platform = findPlatform("Intel(R)");
	if(platform == NULL) {
	printf("ERROR: Unable to find Intel(R) FPGA OpenCL platform.\n");
	return;
	}

/*
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
*/
	// Query the available OpenCL devices.
	scoped_array<cl_device_id> devices;
	cl_uint num_devices;

	devices.reset(getDevices(platform, CL_DEVICE_TYPE_ALL, &num_devices));

	// We'll just use the first device.
	device = devices[0];

	// Display some device information.
	//display_device_info(device);


	// Create the context.
	context = clCreateContext(NULL, 1, &device, &oclContextCallback, NULL, &status);
	checkErr(status, "Failed to create context");

	// Create the command queue.
	queue = clCreateCommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE, &status);
	checkErr(status, "Failed to create command queue");

	// Create the program.
	std::string binary_file = getBoardBinaryFile("hello_world", device);
	printf("Using AOCX: %s\n", binary_file.c_str());
   
  
   
	program = createProgramFromBinary(context, binary_file.c_str(), &device, 1);

  
  
	// Build the program that was just created.
	status = clBuildProgram(program, 0, NULL, "", NULL, NULL);
	checkErr(status, "Failed to build program");

/*
	// Create the kernel - name passed in here must match kernel name in the
	// original CL file, that was compiled into an AOCX file using the AOC tool
	const char *kernel_name = "AOCmm2metersKernel";  // Kernel name, as defined in the CL file
	kernel_1 = clCreateKernel(program, kernel_name, &clError);
	checkErr(clError, "Failed to create kernel");
 
 	kernel_name = "AOCbilateralFilterkernel";  // Kernel name, as defined in the CL file
	kernel_2 = clCreateKernel(program, kernel_name, &clError);
	checkErr(clError, "Failed to create kernel");
 
*/

 
	return;


}



