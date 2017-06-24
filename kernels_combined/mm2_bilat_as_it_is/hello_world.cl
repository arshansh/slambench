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


__constant float gaussian[6]={0.8825,0.9692,1.00,0.9692,0.8825,0.7548};

__attribute__((task))
__kernel void AOCbilateralFilterkernel( __global float * restrict out,
		const __global float * restrict in,
		const float mult_result,
		const int r ,
    const uint2 outSize) {


	//const uint2 pos = (uint2) (get_global_id(0),get_global_id(1));
	//const uint2 size = (uint2) (get_global_size(0),get_global_size(1));


  
  const uint size_x=outSize.x;
  const uint size_y=outSize.y;

  for(uint pos_y=0;pos_y<outSize.y;pos_y++){
				for(uint pos_x=0;pos_x<outSize.x;pos_x++){
        
          	const float center = in[pos_x + size_x * pos_y];
          

          
            uint count=0;
            float t_array[25];
            float sum_array[25];
            
            
          	float sum = 0.0f;
          	float t = 0.0f;


            int i=-3;
            int j=-2;
            
            #pragma unroll
          	for(int count = 0; count < 25; ++count) {
           
                if(count%5==0){
                  i++; 
                  j=-2;
                }

          			const uint2 curPos = (uint2)(clamp(pos_x + i, 0u, size_x-1), clamp(pos_y + j, 0u, size_y-1));
          			const float curPix = in[curPos.x + curPos.y * size_x];
          			if(curPix > 0) {
          				const float mod = (curPix - center)* (curPix - center);
          				const float factor = gaussian[i + r] * gaussian[j + r] * exp(-mod / mult_result);
          				t_array[count] = factor * curPix;
          				sum_array [count] = factor;
          			} 
                j++;
          	}

           //removing loop dependency in sum and t 
           #pragma unroll
           for(int j=0;j<25;j++){
             t += t_array[j];
             sum += sum_array [j];
           }
           
          	out[pos_x + size_x * pos_y] = t / sum;
           

           //To remove the loop caried dependency, this if statement has been moved at the end of the kernel
            if ( center == 0 ) {
            out[pos_x + size_x * pos_y] = 0;
            }
        }
        
    }

}