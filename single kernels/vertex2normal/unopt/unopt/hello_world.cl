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

/*
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

            
          	for(int i = -r; i <= r; ++i) {
          		for(int j = -r; j <= r; ++j) {
          			const uint2 curPos = (uint2)(clamp(pos_x + i, 0u, size_x-1), clamp(pos_y + j, 0u, size_y-1));
          			const float curPix = in[curPos.x + curPos.y * size_x];
          			if(curPix > 0) {
          				const float mod = (curPix - center)* (curPix - center);
          				const float factor = gaussian[i + r] * gaussian[j + r] * exp(-mod / mult_result);
          				t_array[count] = factor * curPix;
          				sum_array [count] = factor;
                  count++;
          			} 
          		}
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
*/

/*
__constant int index_j[4]={0,1,0,1};
__constant int index_i[4]={0,0,1,1};

__attribute__((task))
__kernel void AOChalfSampleRobustImageKernel(__global float * restrict out,
		__global const float *restrict  in,
		const uint2 inSize,
		const float e_d,
    const uint2 outSize) {

	//uint2 pixel = (uint2) (get_global_id(0),get_global_id(1));

 uint pixel_y=-1;
 uint pixel_x=0;
 
 

  for(uint pixel=0;pixel< (outSize.y*outSize.x); pixel++){   
  
            if(pixel%outSize.x==0){
              pixel_y++;
              pixel_x=0;
            }
            
  
     
          	uint2 outSize = inSize / 2;
          
          	const uint centerPixel_x = 2 * pixel_x;
            const uint centerPixel_y = 2 * pixel_y;
          
          	float sum = 0.0f;
          	float t = 0.0f;
           
            uint count=0;
            float t_array[4];
            float sum_array[4];
            
            
          	const float center = in[centerPixel_x + centerPixel_y * inSize.x];

             
             

             
            #pragma unroll 
            for(int count=0;count<4;count++){
            

          			int2 from = (int2)(clamp((int2)(centerPixel_x + index_j[count], centerPixel_y + index_i[count]), (int2)(0), (int2)(inSize.x - 1, inSize.y - 1)));
          			float current = in[from.x + from.y * inSize.x];
          			if(fabs(current - center) < e_d) {
          				sum_array [count] = 1.0f;
          				t_array[count] = current;
          			}
           
          	}
           
           //removing loop dependency in sum and t 
           #pragma unroll
           for(int j=0;j<4;j++){
             t += t_array[j];
             sum += sum_array [j];
           }
          	out[pixel_x + pixel_y * outSize.x] = t / sum;
           
           
   pixel_x++;     
  }
}


*/

/*

typedef struct sMatrix4 {
	float4 data[4];
} Matrix4;


inline float3 myrotate(__global const Matrix4 * restrict M, const float3 v) {
	return (float3)(dot((float3)(M->data[0].x, M->data[0].y, M->data[0].z), v),
			dot((float3)(M->data[1].x, M->data[1].y, M->data[1].z), v),
			dot((float3)(M->data[2].x, M->data[2].y, M->data[2].z), v));
}



__kernel void AOCdepth2vertexKernel( __global float * restrict vertex, // float3
		const uint2 vertexSize ,
		const __global float * restrict depth,
		const uint2 depthSize ,
		__global const  Matrix4* restrict invK,
    const uint2 outSize ) {

	//uint2 pixel = (uint2) (get_global_id(0),get_global_id(1));
	//float3 vert = (float3)(get_global_id(0),get_global_id(1),1.0f);

  float3 vert= (float3)  (outSize.x,outSize.y,1.0f);
  

  for(int pixel_y=0;pixel_y<outSize.y;pixel_y++){
  

    for(int pixel_x=0;pixel_x<outSize.x;pixel_x++){
      
      
      
      	if(pixel_x < depthSize.x || pixel_y < depthSize.y ) {

      	
      
      	float3 res = (float3) (0);
      
      	if(depth[pixel_x + depthSize.x * pixel_y] > 0) {
      		res = depth[pixel_x + depthSize.x * pixel_y] * (myrotate(invK, (float3)(pixel_x, pixel_y, 1.f)));
      	}
      
      	 vstore3(res, pixel_x + vertexSize.x * pixel_y,vertex); 	// vertex[pixel] =
         //vertex[pixel_x + pixel_y * outSize.x]=res;
       }
    }
  }

}

*/

#define INVALID -2 

__kernel void AOCvertex2normalKernel( __global float * normal,    // float3
		const uint2 normalSize,
		const __global float * vertex ,
		const uint2 vertexSize ) {  // float3

	uint2 pixel = (uint2) (get_global_id(0),get_global_id(1));

	if(pixel.x >= vertexSize.x || pixel.y >= vertexSize.y )
	return;

	//const float3 left = vertex[(uint2)(max(int(pixel.x)-1,0), pixel.y)];
	//const float3 right = vertex[(uint2)(min(pixel.x+1,vertex.size.x-1), pixel.y)];
	//const float3 up = vertex[(uint2)(pixel.x, max(int(pixel.y)-1,0))];
	//const float3 down = vertex[(uint2)(pixel.x, min(pixel.y+1,vertex.size.y-1))];

	uint2 vleft = (uint2)(max((int)(pixel.x)-1,0), pixel.y);
	uint2 vright = (uint2)(min(pixel.x+1,vertexSize.x-1), pixel.y);
	uint2 vup = (uint2)(pixel.x, max((int)(pixel.y)-1,0));
	uint2 vdown = (uint2)(pixel.x, min(pixel.y+1,vertexSize.y-1));

	const float3 left = vload3(vleft.x + vertexSize.x * vleft.y,vertex);
	const float3 right = vload3(vright.x + vertexSize.x * vright.y,vertex);
	const float3 up = vload3(vup.x + vertexSize.x * vup.y,vertex);
	const float3 down = vload3(vdown.x + vertexSize.x * vdown.y,vertex);
	/*
	 unsigned long int val =  0 ;
	 val = max(((int) pixel.x)-1,0) + vertexSize.x * pixel.y;
	 const float3 left   = vload3(   val,vertex);

	 val =  min(pixel.x+1,vertexSize.x-1)                  + vertexSize.x *     pixel.y;
	 const float3 right  = vload3(    val     ,vertex);
	 val =   pixel.x                        + vertexSize.x *     max(((int) pixel.y)-1,0)  ;
	 const float3 up     = vload3(  val ,vertex);
	 val =  pixel.x                       + vertexSize.x *   min(pixel.y+1,vertexSize.y-1)   ;
	 const float3 down   = vload3(  val   ,vertex);
	 */
	if(left.z == 0 || right.z == 0|| up.z ==0 || down.z == 0) {
		//float3 n = vload3(pixel.x + normalSize.x * pixel.y,normal);
		//n.x=INVALID;
		vstore3((float3)(INVALID,INVALID,INVALID),pixel.x + normalSize.x * pixel.y,normal);
		return;
	}
	const float3 dxv = right - left;
	const float3 dyv = down - up;
	vstore3((float3) normalize(cross(dyv, dxv)), pixel.x + pixel.y * normalSize.x, normal );

}


