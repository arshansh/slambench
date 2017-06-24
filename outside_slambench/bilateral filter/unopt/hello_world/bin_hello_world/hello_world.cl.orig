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
__constant float gaussian[6]= {0.8825, 0.9692, 1.0000, 0.9692, 0.8825, 0.7548};



__kernel void hello_world( __global float * out,
		const __global float * in,
		const float mult_result) {

	const uint2 pos = (uint2) (get_global_id(0),get_global_id(1));
	const uint2 size = (uint2) (get_global_size(0),get_global_size(1));

	const float center = in[pos.x + size.x * pos.y];

	if ( center == 0 ) {
		out[pos.x + size.x * pos.y] = 0;
		return;
	}

	float sum = 0.0f;
	float t = 0.0f;

	float factor[25];
	float curPix[25]; 
	// FIXME : sum and t diverge too much from cpp version
	for(int i = 0; i <= 25; ++i) {

			const uint2 curPos = (uint2)(clamp(pos.x + i, 0u, size.x-1), clamp(pos.y + i, 0u, size.y-1));
			curPix[i] = in[curPos.x + curPos.y * size.x];
			if(curPix[i] > 0) {
				const float mod = (curPix[i] - center)*(curPix[i] - center);
				factor[i] = gaussian[i + 2] * gaussian[i + 2] * exp(-mod / (mult_result));

			}
	}

	for(int j=0;j<25;j++){
		t += factor[j] * curPix[j];
		sum += factor[j];

	}	


	
	
	out[pos.x + size.x * pos.y] = t / sum;

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
