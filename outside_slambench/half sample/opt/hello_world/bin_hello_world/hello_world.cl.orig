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



__kernel void AOChalfSampleRobustImageKernel(__global float * out,
		__global const float * in,
		const uint inSize_x,
		const uint inSize_y,
		const float e_d,
		const int r) {



	//to be fixed
	//uint2 inSize=(inSize_x,inSize_y);

	//uint2 outSize = inSize / 2;
	uint outSize_x = inSize_x / 2;
	uint outSize_y = inSize_y / 2;

	//uint2 pixel = (uint2) (get_global_id(0),get_global_id(1));
	for(uint pixel_y=0;pixel_y< outSize_y;pixel_y++){
		for(uint pixel_x=0;pixel_x< outSize_x;pixel_x++){


			const uint centerPixel_x = 2 * pixel_x;
			const uint centerPixel_y = 2 * pixel_y;

			float sum = 0.0f;
			float t = 0.0f;
			const float center = in[centerPixel_x + centerPixel_y * inSize_x];
			for(int i = -r + 1; i <= r; ++i) {
				for(int j = -r + 1; j <= r; ++j) {
					int2 from = (int2)(clamp((int2)(centerPixel_x + j, centerPixel_y + i), (int2)(0), (int2)(inSize_x - 1, inSize_y - 1)));
					float current = in[from.x + from.y * inSize_x];
					if(fabs(current - center) < e_d) {
						sum += 1.0f;
						t += current;
					}
				}
			}
			out[pixel_x + pixel_y * outSize_x] = t / sum;
		}
	}
}

