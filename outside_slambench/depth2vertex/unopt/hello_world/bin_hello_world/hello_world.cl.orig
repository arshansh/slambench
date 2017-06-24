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


*/




typedef struct sMatrix4 {
	float4 data[4];
} Matrix4;




inline float3 myrotate(const Matrix4 M, const float3 v) {
	return (float3)(dot((float3)(M.data[0].x, M.data[0].y, M.data[0].z), v),
			dot((float3)(M.data[1].x, M.data[1].y, M.data[1].z), v),
			dot((float3)(M.data[2].x, M.data[2].y, M.data[2].z), v));
}

__kernel void AOCdepth2vertexKernel( __global float * vertex, // float3
		const uint vertexSize_x ,
		const uint vertexSize_y ,
		const __global float * depth,
		const uint depthSize_x ,
		const uint depthSize_y ,
		__global float * invK_float ) {


	Matrix4 invK;
	int j=0;
	int i=-1;
	while(j<4){
		invK.data[j].x=invK_float[++i];
		invK.data[j].y=invK_float[++i];
		invK.data[j].z=invK_float[++i];
		invK.data[j].w=invK_float[++i];
		j++;
	}


/*
	invK.data[0]=(invK_float[0],invK_float[1],invK_float[2],invK_float[3]);
	invK.data[1]=(invK_float[4],invK_float[5],invK_float[6],invK_float[7]);
	invK.data[2]=(invK_float[8],invK_float[9],invK_float[10],invK_float[11]);
	invK.data[3]=(invK_float[12],invK_float[13],invK_float[14],invK_float[15]);
*/

	
	uint2 pixel = (uint2) (get_global_id(0),get_global_id(1));
	float3 vert = (float3)(get_global_id(0),get_global_id(1),1.0f);

	if(pixel.x >= depthSize_x || pixel.y >= depthSize_y ) {
		return;
	}

	float3 res = (float3) (0);

	if(depth[pixel.x + depthSize_x * pixel.y] > 0) {
		res = depth[pixel.x + depthSize_x * pixel.y] * (myrotate(invK, (float3)(pixel.x, pixel.y, 1.f)));
	}

	vstore3(res, pixel.x + vertexSize_x * pixel.y,vertex); 	// vertex[pixel] =

}

