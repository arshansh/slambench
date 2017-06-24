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



typedef struct sMatrix4 {
	float4 data[4];
} Matrix4;

typedef struct sVolume {
	uint3 size;
	float3 dim;
  __global short2 * restrict  data;
} Volume;


inline float sq(float r) {
	return r * r;
}

inline void setVolume(Volume v, uint3 pos, float2 d) {
	v.data[pos.x + pos.y * v.size.x + pos.z * v.size.x * v.size.y] = (short2)(
			d.x * 32766.0f, d.y);
}

inline float3 posVolume(const Volume v, const uint3 p) {
	return (float3)((p.x + 0.5f) * v.dim.x / v.size.x,
			(p.y + 0.5f) * v.dim.y / v.size.y,
			(p.z + 0.5f) * v.dim.z / v.size.z);
}

inline float2 getVolume(const Volume v, const uint3 pos) {
	const short2 d = v.data[pos.x + pos.y * v.size.x
			+ pos.z * v.size.x * v.size.y];
	return (float2)(d.x * 0.00003051944088f, d.y); //  / 32766.0f
}

inline float3 Mat4TimeFloat3(	__global const  Matrix4* restrict M, float3 v) {
	return (float3)(
			dot((float3)(M->data[0].x, M->data[0].y, M->data[0].z), v)
					+ M->data[0].w,
			dot((float3)(M->data[1].x, M->data[1].y, M->data[1].z), v)
					+ M->data[1].w,
			dot((float3)(M->data[2].x, M->data[2].y, M->data[2].z), v)
					+ M->data[2].w);
}



//__attribute__(  (num_simd_work_items(2))  )
__attribute__((reqd_work_group_size(32,32,1)))
__attribute__(  (num_compute_units(4))  )


__kernel void AOCintegrateKernel (
		__global short2 * restrict v_data,
		const uint3 v_size,
		const float3 v_dim,
		__global const float * restrict depth,
		const uint2 depthSize,
			__global const  Matrix4* restrict invTrack,
			__global const  Matrix4* restrict K,
		const float mu,
		const float maxweight ,
		const float3 delta ,
		const float3 cameraDelta
) {

  
	Volume vol; vol.data=v_data;vol.size = v_size; vol.dim = v_dim;

    	uint3 pix = (uint3) (get_global_id(0),get_global_id(1),0);
    	
    
    	float3 pos = Mat4TimeFloat3 (invTrack , posVolume(vol,pix));
    	float3 cameraX = Mat4TimeFloat3 ( K , pos);
    
    	for(pix.z = 0; pix.z < vol.size.z; ++pix.z, pos += delta, cameraX += cameraDelta) {
    		if(pos.z < 0.0001f) // some near plane constraint
    		continue;
    		const float2 pixel = (float2) (cameraX.x/cameraX.z + 0.5f, cameraX.y/cameraX.z + 0.5f);
    
    		if(pixel.x < 0 || pixel.x > depthSize.x-1 || pixel.y < 0 || pixel.y > depthSize.y-1)
    		continue;
    		const uint2 px = (uint2)(pixel.x, pixel.y);
    		float depthpx = depth[px.x + depthSize.x * px.y];
    
    		if(depthpx == 0) continue;
    		const float diff = ((depthpx) - cameraX.z) * sqrt(1+sq(pos.x/pos.z) + sq(pos.y/pos.z));
    
    		if(diff > -mu) {
    			const float sdf = fmin(1.f, diff/mu);
    			float2 data = getVolume(vol,pix);
    			data.x = clamp((data.y*data.x + sdf)/(data.y + 1), -1.f, 1.f);
    			data.y = fmin(data.y+1, maxweight);
    			setVolume(vol,pix, data);
    		}
    	}
 
}


