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

// AOC kernel demonstrating device-side printf call

/*
__kernel void hello_world(int thread_id_from_which_to_print_message) {
  // Get index of the work item
  unsigned thread_id = get_global_id(0);

  if(thread_id == thread_id_from_which_to_print_message) {
    printf("Thread #%u: Hello from Altera's OpenCL Compiler!\n", thread_id);
  }
}
*/

/*

//__attribute__(  (num_simd_work_items(8))  )
//__attribute__((reqd_work_group_size(80,60,1)))

//__attribute__(  (num_compute_units(4))  )


__attribute__((task))
__kernel void AOCmm2metersKernel(
		__global float * restrict depth,
		const uint depthSize_x ,
		const uint depthSize_y ,
		const __global ushort * restrict in ,
		const uint inSize_x ,
		const int ratio ) 
{
	for(uint pixel_y=0;pixel_y<depthSize_y;pixel_y++){
    #pragma unroll 5
		for(uint pixel_x=0;pixel_x<depthSize_x;pixel_x++){
			depth[pixel_x + depthSize_x * pixel_y] = in[pixel_x * ratio + inSize_x * pixel_y * ratio] / 1000.0f;
		}
	}
}


*/



inline float sq(float r) {
	return r * r;
}



__kernel void AOCbilateralFilterkernel( __global float * out,
		const __global float * in,
		const __global float * gaussian,
		const float e_d,
		const int r ) {

	const uint2 pos = (uint2) (get_global_id(0),get_global_id(1));
	const uint2 size = (uint2) (get_global_size(0),get_global_size(1));

	const float center = in[pos.x + size.x * pos.y];

	if ( center == 0 ) {
		out[pos.x + size.x * pos.y] = 0;
		return;
	}

	float sum = 0.0f;
	float t = 0.0f;
	// FIXME : sum and t diverge too much from cpp version
	for(int i = -r; i <= r; ++i) {
		for(int j = -r; j <= r; ++j) {
			const uint2 curPos = (uint2)(clamp(pos.x + i, 0u, size.x-1), clamp(pos.y + j, 0u, size.y-1));
			const float curPix = in[curPos.x + curPos.y * size.x];
			if(curPix > 0) {
				const float mod = sq(curPix - center);
				const float factor = gaussian[i + r] * gaussian[j + r] * exp(-mod / (2 * e_d * e_d));
				t += factor * curPix;
				sum += factor;
			} else {
				//std::cerr << "ERROR BILATERAL " <<pos.x+i<< " "<<pos.y+j<< " " <<curPix<<" \n";
			}
		}
	}
	out[pos.x + size.x * pos.y] = t / sum;

}