/*

 Copyright (c) 2014 University of Edinburgh, Imperial College, University of Manchester.
 Developed in the PAMELA project, EPSRC Programme Grant EP/K008730/1

 This code is licensed under the MIT License.

 */

#include <kernels.h>
#include <interface.h>
#include <stdint.h>
#include <vector>
#include <sstream>
#include <string>
#include <cstring>
#include <time.h>
#include <csignal>

#include <sys/types.h>
#include <sys/stat.h>
#include <sstream>
#include <iomanip>
#include <getopt.h>


#include<iostream>



////////////////////////////////////////
#include "CL/opencl.h"
/////////////////////////////////////


inline double tock() {
	synchroniseDevices();
#ifdef __APPLE__
		clock_serv_t cclock;
		mach_timespec_t clockData;
		host_get_clock_service(mach_host_self(), SYSTEM_CLOCK, &cclock);
		clock_get_time(cclock, &clockData);
		mach_port_deallocate(mach_task_self(), cclock);
#else
		struct timespec clockData;
		clock_gettime(CLOCK_MONOTONIC, &clockData);
#endif
		return (double) clockData.tv_sec + clockData.tv_nsec / 1000000000.0;
}	

///////////////////////////////////////////////////
// This is the minimum alignment requirement to ensure DMA can be used.
const unsigned AOCL_ALIGNMENT = 64;

#ifdef _WIN32 // Windows
void *alignedMalloc_host(size_t size) {
  return _aligned_malloc (size, AOCL_ALIGNMENT);
}

void alignedFree_host(void * ptr) {
  _aligned_free(ptr);
}
#else          // Linux
void *alignedMalloc_host(size_t size) {
  void *result = NULL;
  int rc;
  rc = posix_memalign (&result, AOCL_ALIGNMENT, size);
  return result;
}

void alignedFree_host(void * ptr) {
  free (ptr);
}
#endif
////////////////////////////////////////////////////

/***
 * This program loop over a scene recording
 */

int main(int argc, char ** argv) {

	Configuration config(argc, argv);

	// ========= CHECK ARGS =====================

	std::ostream* logstream = &std::cout;
	std::ofstream logfilestream;
	assert(config.compute_size_ratio > 0);
	assert(config.integration_rate > 0);
	assert(config.volume_size.x > 0);
	assert(config.volume_resolution.x > 0);

	if (config.log_file != "") {
		logfilestream.open(config.log_file.c_str());
		logstream = &logfilestream;
	}
	if (config.input_file == "") {
		std::cerr << "No input found." << std::endl;
		config.print_arguments();
		exit(1);
	}

	// ========= READER INITIALIZATION  =========

	DepthReader * reader;

	if (is_file(config.input_file)) {
		reader = new RawDepthReader(config.input_file, config.fps,
				config.blocking_read);

	} else {
		reader = new SceneDepthReader(config.input_file, config.fps,
				config.blocking_read);
	}

	std::cout.precision(10);
	std::cerr.precision(10);

	float3 init_pose = config.initial_pos_factor * config.volume_size;
	const uint2 inputSize = reader->getinputSize();
	std::cerr << "input Size is = " << inputSize.x << "," << inputSize.y
			<< std::endl;

	

	//  =========  BASIC PARAMETERS  (input size / computation size )  =========

	const uint2 computationSize = make_uint2(
			inputSize.x / config.compute_size_ratio,
			inputSize.y / config.compute_size_ratio);
	float4 camera = reader->getK() / config.compute_size_ratio;

	if (config.camera_overrided)
		camera = config.camera / config.compute_size_ratio;
	//  =========  BASIC BUFFERS  (input / output )  =========

	// Construction Scene reader and input buffer
	//input depth decleration
	uint16_t* inputDepth = (uint16_t *)alignedMalloc_host(sizeof(uint16_t) * inputSize.x * inputSize.y);
      
	//uchar4* depthRender = (uchar4*) malloc(
	//		sizeof(uchar4) * computationSize.x * computationSize.y);
  uchar4* depthRender = (uchar4*)alignedMalloc_host(sizeof(uchar4) * computationSize.x * computationSize.y);    
      
	//uchar4* trackRender = (uchar4*) malloc(
	//		sizeof(uchar4) * computationSize.x * computationSize.y);
   uchar4* trackRender = (uchar4*)alignedMalloc_host(sizeof(uchar4) * computationSize.x * computationSize.y);
 
	//uchar4* volumeRender = (uchar4*) malloc(
	//		sizeof(uchar4) * computationSize.x * computationSize.y);
 uchar4* volumeRender = (uchar4*)alignedMalloc_host(sizeof(uchar4) * computationSize.x * computationSize.y);

	uint frame = 0;

	Kfusion kfusion(computationSize, config.volume_resolution,
			config.volume_size, init_pose, config.pyramid);

	double timings[7];
	timings[0] = tock();

	*logstream
			<< "frame\tacquisition\tpreprocessing\ttracking\tintegration\traycasting\trendering\tcomputation\ttotal    \tX          \tY          \tZ         \ttracked   \tintegrated"
			<< std::endl;
	logstream->setf(std::ios::fixed, std::ios::floatfield);

	while (reader->readNextDepthFrame(inputDepth)) {

		Matrix4 pose = kfusion.getPose();

		float xt = pose.data[0].w - init_pose.x;
		float yt = pose.data[1].w - init_pose.y;
		float zt = pose.data[2].w - init_pose.z;

		timings[1] = tock();
		
		kfusion.preprocessing(inputDepth, inputSize,frame);

		timings[2] = tock();

		bool tracked = kfusion.tracking(camera, config.icp_threshold,
				config.tracking_rate, frame);

		timings[3] = tock();

		bool integrated = kfusion.integration(camera, config.integration_rate,
				config.mu, frame);

		timings[4] = tock();

		bool raycast = kfusion.raycasting(camera, config.mu, frame);

		timings[5] = tock();

		kfusion.renderDepth(depthRender, computationSize);
		kfusion.renderTrack(trackRender, computationSize);
		kfusion.renderVolume(volumeRender, computationSize, frame,
				config.rendering_rate, camera, 0.75 * config.mu);
   

 		//kfusion.renderDepth_Track(depthRender,trackRender,computationSize);
		//kfusion.renderVolume(volumeRender, computationSize, frame,
				//config.rendering_rate, camera, 0.75 * config.mu);




		timings[6] = tock();




  kfusion.frame_vector.push_back(timings[6] - timings[0]);



		*logstream << frame << "\t" << timings[1] - timings[0] << "\t" //  acquisition
				<< timings[2] - timings[1] << "\t"     //  preprocessing
				<< timings[3] - timings[2] << "\t"     //  tracking
				<< timings[4] - timings[3] << "\t"     //  integration
				<< timings[5] - timings[4] << "\t"     //  raycasting
				<< timings[6] - timings[5] << "\t"     //  rendering
				<< timings[5] - timings[1] << "\t"     //  computation
				<< timings[6] - timings[0] << "\t"     //  total
				<< xt << "\t" << yt << "\t" << zt << "\t"     //  X,Y,Z
				<< tracked << "        \t" << integrated // tracked and integrated flags
				<< std::endl;



//////////////// counting frames..printed at the end of the timings of the printed frame
		std::cerr <<frame<<std::endl;
		std::cerr <<""<<std::endl;
		std::cerr <<""<<std::endl;
		std::cerr <<""<<std::endl;
		std::cerr <<""<<std::endl;
///////////////


		frame++;

		timings[0] = tock();
	}

/////////////////printing average timing

  double average_frame=  std::accumulate (kfusion.frame_vector.begin(),kfusion.frame_vector.end(),0.0)/ kfusion.frame_vector.size();
    
  std::cerr << "avaerage frame time in s is:"<< average_frame<<" "<< kfusion.frame_vector.size()<<std::endl;
  std::cerr<< "frame rate is:" << 1/(average_frame) <<std::endl;    


	//average of write
	float average_write = std::accumulate ( kfusion.write_vector.begin(),kfusion.write_vector.end(),0.0)/ kfusion.write_vector.size() ;
	
	//average kernel
	float average_kernel = std::accumulate (kfusion.kernel_vector.begin(),kfusion.kernel_vector.end(),0.0)/ kfusion.kernel_vector.size();

	//average read
	float average_read = std::accumulate (kfusion.read_vector.begin(),kfusion.read_vector.end(),0.0)/ kfusion.read_vector.size();



	std::cerr << "avaerage write time is:"<< average_write<<std::endl;
	std::cerr << "avaerage kernel time is:"<< average_kernel<<std::endl;
	std::cerr << "avaerage read time is:"<< average_read<<std::endl;



/////////////////

	// ==========     DUMP VOLUME      =========

	if (config.dump_volume_file != "") {
		kfusion.dumpVolume(config.dump_volume_file);
	}

	//  =========  FREE BASIC BUFFERS  =========

	free(inputDepth);
	free(depthRender);
	free(trackRender);
	free(volumeRender);
	return 0;

}

