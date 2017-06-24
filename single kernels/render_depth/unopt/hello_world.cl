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

/*

int find_min(int a,int b){

  int min=a;
  if(a>b){
    min=b;
  }
  return min;
}

int find_max(int a,int b){

  int max=a;
  if(b>a){
    max=b;
  }
  return max;
}


#define INVALID -2 

__kernel void AOCvertex2normalKernel( __global float * restrict normal,    // float3
		const uint2 normalSize,
		const __global float * restrict vertex ,
		const uint2 vertexSize,
    const uint2 outSize ) {  // float3

	//uint2 pixel = (uint2) (get_global_id(0),get_global_id(1));


  for(int pixel_y=0;pixel_y<outSize.y;pixel_y++){
  

    for(int pixel_x=0;pixel_x<outSize.x;pixel_x++){

      	if(pixel_x < vertexSize.x || pixel_y < vertexSize.y ){
      
      	uint2 vleft = (uint2)(find_max((int)(pixel_x)-1,0), pixel_y);
      	uint2 vright = (uint2)(find_min(pixel_x+1,vertexSize.x-1), pixel_y);
      	uint2 vup = (uint2)(pixel_x, find_max((int)(pixel_y)-1,0));
      	uint2 vdown = (uint2)(pixel_x, find_min(pixel_y+1,vertexSize.y-1));
      
      	const float3 left = vload3(vleft.x + vertexSize.x * vleft.y,vertex);
      	const float3 right = vload3(vright.x + vertexSize.x * vright.y,vertex);
      	const float3 up = vload3(vup.x + vertexSize.x * vup.y,vertex);
      	const float3 down = vload3(vdown.x + vertexSize.x * vdown.y,vertex);
      
      	if(left.z == 0 || right.z == 0|| up.z ==0 || down.z == 0) {
      		vstore3((float3)(INVALID,INVALID,INVALID),pixel_x + normalSize.x * pixel_y,normal);
        // normal[pixel_x + normalSize.x * pixel_y] = 1;;
      	}
        else{
        	const float3 dxv = right - left;
        	const float3 dyv = down - up;
        	vstore3((float3) normalize(cross(dyv, dxv)), pixel_x + pixel_y * normalSize.x, normal );
           //normal[pixel_x + pixel_y * normalSize.x] = 2; // switched dx and dy to get factor -1
        }
       }       
    }
  }
}
*/



/*
#define INVALID -2 

typedef struct sTrackData {
	int result;
	float error;
	float J[6];
} TrackData;

typedef struct sMatrix4 {
	float4 data[4];
} Matrix4;


inline float3 Mat4TimeFloat3(__global const  Matrix4* restrict M , float3 v) {
	return (float3)(
			dot((float3)(M->data[0].x, M->data[0].y, M->data[0].z), v)
					+ M->data[0].w,
			dot((float3)(M->data[1].x, M->data[1].y, M->data[1].z), v)
					+ M->data[1].w,
			dot((float3)(M->data[2].x, M->data[2].y, M->data[2].z), v)
					+ M->data[2].w);
}
inline float3 myrotate(__global const  Matrix4* restrict M, const float3 v) {
	return (float3)(dot((float3)(M->data[0].x, M->data[0].y, M->data[0].z), v),
			dot((float3)(M->data[1].x, M->data[1].y, M->data[1].z), v),
			dot((float3)(M->data[2].x, M->data[2].y, M->data[2].z), v));
}



//__attribute__(  (num_simd_work_items(2))  )
//__attribute__((reqd_work_group_size(80,60,1)))
//__attribute__(  (num_compute_units(2))  )

// inVertex iterate
__kernel void AOCtrackKernel (
		__global TrackData * restrict output,
		const uint2 outputSize,
		__global const float * restrict  inVertex,// float3
		const uint2 inVertexSize,
		__global const float * restrict inNormal,// float3
		const uint2 inNormalSize,
		__global const float * restrict refVertex,// float3
		const uint2 refVertexSize,
		__global const float * restrict refNormal,// float3
		const uint2 refNormalSize,
		__global const  Matrix4* restrict Ttrack,
		__global const  Matrix4* restrict view,
		const float dist_threshold,
		const float normal_threshold,
    const uint2 outSize
) {

	//const uint2 pixel = (uint2)(get_global_id(0),get_global_id(1));

	const uint2 pixel = (uint2)(get_global_id(0),get_global_id(1));

	if(pixel.x >= inVertexSize.x || pixel.y >= inVertexSize.y ) {return;}

	float3 inNormalPixel = vload3(pixel.x + inNormalSize.x * pixel.y,inNormal);

	if(inNormalPixel.x == INVALID ) {
		output[pixel.x + outputSize.x * pixel.y].result = -1;
		return;
	}

	float3 inVertexPixel = vload3(pixel.x + inVertexSize.x * pixel.y,inVertex);
	const float3 projectedVertex = Mat4TimeFloat3 (Ttrack , inVertexPixel);
	const float3 projectedPos = Mat4TimeFloat3 ( view , projectedVertex);
	const float2 projPixel = (float2) ( projectedPos.x / projectedPos.z + 0.5f, projectedPos.y / projectedPos.z + 0.5f);

	if(projPixel.x < 0 || projPixel.x > refVertexSize.x-1 || projPixel.y < 0 || projPixel.y > refVertexSize.y-1 ) {
		output[pixel.x + outputSize.x * pixel.y].result = -2;
		return;
	}

	const uint2 refPixel = (uint2) (projPixel.x, projPixel.y);
	const float3 referenceNormal = vload3(refPixel.x + refNormalSize.x * refPixel.y,refNormal);

	if(referenceNormal.x == INVALID) {
		output[pixel.x + outputSize.x * pixel.y].result = -3;
		return;
	}

	const float3 diff = vload3(refPixel.x + refVertexSize.x * refPixel.y,refVertex) - projectedVertex;
	const float3 projectedNormal = myrotate(Ttrack, inNormalPixel);

	if(length(diff) > dist_threshold ) {
		output[pixel.x + outputSize.x * pixel.y].result = -4;
		return;
	}
	if(dot(projectedNormal, referenceNormal) < normal_threshold) {
		output[pixel.x + outputSize.x * pixel.y] .result = -5;
		return;
	}

	output[pixel.x + outputSize.x * pixel.y].result = 1;
	output[pixel.x + outputSize.x * pixel.y].error = dot(referenceNormal, diff);

	vstore3(referenceNormal,0,(output[pixel.x + outputSize.x * pixel.y].J));
	vstore3(cross(projectedVertex, referenceNormal),1,(output[pixel.x + outputSize.x * pixel.y].J));


}
*/
/*

typedef struct sTrackData {
	int result;
	float error;
	float J[6];
} TrackData;


__kernel void AOCreduceKernel (
		__global float * out,
		__global const TrackData * J,
		const uint2 JSize,
		const uint2 size,
		__local float * S
) {

	uint blockIdx = get_group_id(0);
	uint blockDim = get_local_size(0);
	uint threadIdx = get_local_id(0);
	uint gridDim = get_num_groups(0);

	const uint sline = threadIdx;

	float sums[32];
	float * jtj = sums + 7;
	float * info = sums + 28;

	for(uint i = 0; i < 32; ++i)
	sums[i] = 0.0f;

	for(uint y = blockIdx; y < size.y; y += gridDim) {
		for(uint x = sline; x < size.x; x += blockDim ) {
			const TrackData row = J[x + y * JSize.x];
			if(row.result < 1) {
				info[1] += row.result == -4 ? 1 : 0;
				info[2] += row.result == -5 ? 1 : 0;
				info[3] += row.result > -4 ? 1 : 0;
				continue;
			}

			// Error part
			sums[0] += row.error * row.error;

			// JTe part
			for(int i = 0; i < 6; ++i)
			sums[i+1] += row.error * row.J[i];

			jtj[0] += row.J[0] * row.J[0];
			jtj[1] += row.J[0] * row.J[1];
			jtj[2] += row.J[0] * row.J[2];
			jtj[3] += row.J[0] * row.J[3];
			jtj[4] += row.J[0] * row.J[4];
			jtj[5] += row.J[0] * row.J[5];

			jtj[6] += row.J[1] * row.J[1];
			jtj[7] += row.J[1] * row.J[2];
			jtj[8] += row.J[1] * row.J[3];
			jtj[9] += row.J[1] * row.J[4];
			jtj[10] += row.J[1] * row.J[5];

			jtj[11] += row.J[2] * row.J[2];
			jtj[12] += row.J[2] * row.J[3];
			jtj[13] += row.J[2] * row.J[4];
			jtj[14] += row.J[2] * row.J[5];

			jtj[15] += row.J[3] * row.J[3];
			jtj[16] += row.J[3] * row.J[4];
			jtj[17] += row.J[3] * row.J[5];

			jtj[18] += row.J[4] * row.J[4];
			jtj[19] += row.J[4] * row.J[5];

			jtj[20] += row.J[5] * row.J[5];
			// extra info here
			info[0] += 1;
		}
	}

	for(int i = 0; i < 32; ++i) // copy over to shared memory
	S[sline * 32 + i] = sums[i];

	barrier(CLK_LOCAL_MEM_FENCE);

	if(sline < 32) { // sum up columns and copy to global memory in the final 32 threads
		for(unsigned i = 1; i < blockDim; ++i)
		S[sline] += S[i * 32 + sline];
		out[sline+blockIdx*32] = S[sline];
	}
}


*/
/*
typedef struct sMatrix4 {
	float4 data[4];
} Matrix4;

typedef struct sVolume {
	uint3 size;
	float3 dim;
	__global short2 * data;
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

inline float3 Mat4TimeFloat3(	__global const  Matrix4* M, float3 v) {
	return (float3)(
			dot((float3)(M->data[0].x, M->data[0].y, M->data[0].z), v)
					+ M->data[0].w,
			dot((float3)(M->data[1].x, M->data[1].y, M->data[1].z), v)
					+ M->data[1].w,
			dot((float3)(M->data[2].x, M->data[2].y, M->data[2].z), v)
					+ M->data[2].w);
}


__kernel void AOCintegrateKernel (
		__global short2 * v_data,
		const uint3 v_size,
		const float3 v_dim,
		__global const float * depth,
		const uint2 depthSize,
			__global const  Matrix4* invTrack,
			__global const  Matrix4* K,
		const float mu,
		const float maxweight ,
		const float3 delta ,
		const float3 cameraDelta
) {

	Volume vol; vol.data = v_data; vol.size = v_size; vol.dim = v_dim;

	uint3 pix = (uint3) (get_global_id(0),get_global_id(1),0);
	const int sizex = get_global_size(0);

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
*/



typedef struct sMatrix4 {
	float4 data[4];
} Matrix4;

typedef struct sVolume {
	uint3 size;
	float3 dim;
	__global short2 * data;
} Volume;



#define INVALID -2 


inline float vs(const uint3 pos, const Volume v) {
	return v.data[pos.x + pos.y * v.size.x + pos.z * v.size.x * v.size.y].x;
}


inline float interp(const float3 pos, const Volume v) {
	const float3 scaled_pos = (float3)((pos.x * v.size.x / v.dim.x) - 0.5f,
			(pos.y * v.size.y / v.dim.y) - 0.5f,
			(pos.z * v.size.z / v.dim.z) - 0.5f);
	float3 basef = (float3)(0);
	const int3 base = convert_int3(floor(scaled_pos));
	const float3 factor = (float3)(fract(scaled_pos, (float3 *) &basef));
	const int3 lower = max(base, (int3)(0));
	const int3 upper = min(base + (int3)(1), convert_int3(v.size) - (int3)(1));
	return (((vs((uint3)(lower.x, lower.y, lower.z), v) * (1 - factor.x)
			+ vs((uint3)(upper.x, lower.y, lower.z), v) * factor.x)
			* (1 - factor.y)
			+ (vs((uint3)(lower.x, upper.y, lower.z), v) * (1 - factor.x)
					+ vs((uint3)(upper.x, upper.y, lower.z), v) * factor.x)
					* factor.y) * (1 - factor.z)
			+ ((vs((uint3)(lower.x, lower.y, upper.z), v) * (1 - factor.x)
					+ vs((uint3)(upper.x, lower.y, upper.z), v) * factor.x)
					* (1 - factor.y)
					+ (vs((uint3)(lower.x, upper.y, upper.z), v)
							* (1 - factor.x)
							+ vs((uint3)(upper.x, upper.y, upper.z), v)
									* factor.x) * factor.y) * factor.z)
			* 0.00003051944088f;
}


inline float3 grad(float3 pos, const Volume v) {
	const float3 scaled_pos = (float3)((pos.x * v.size.x / v.dim.x) - 0.5f,
			(pos.y * v.size.y / v.dim.y) - 0.5f,
			(pos.z * v.size.z / v.dim.z) - 0.5f);
	const int3 base = (int3)(floor(scaled_pos.x), floor(scaled_pos.y),
			floor(scaled_pos.z));
	const float3 basef = (float3)(0);
	const float3 factor = (float3) fract(scaled_pos, (float3 *) &basef);
	const int3 lower_lower = max(base - (int3)(1), (int3)(0));
	const int3 lower_upper = max(base, (int3)(0));
	const int3 upper_lower = min(base + (int3)(1),
			convert_int3(v.size) - (int3)(1));
	const int3 upper_upper = min(base + (int3)(2),
			convert_int3(v.size) - (int3)(1));
	const int3 lower = lower_upper;
	const int3 upper = upper_lower;

	float3 gradient;

	gradient.x = (((vs((uint3)(upper_lower.x, lower.y, lower.z), v)
			- vs((uint3)(lower_lower.x, lower.y, lower.z), v)) * (1 - factor.x)
			+ (vs((uint3)(upper_upper.x, lower.y, lower.z), v)
					- vs((uint3)(lower_upper.x, lower.y, lower.z), v))
					* factor.x) * (1 - factor.y)
			+ ((vs((uint3)(upper_lower.x, upper.y, lower.z), v)
					- vs((uint3)(lower_lower.x, upper.y, lower.z), v))
					* (1 - factor.x)
					+ (vs((uint3)(upper_upper.x, upper.y, lower.z), v)
							- vs((uint3)(lower_upper.x, upper.y, lower.z), v))
							* factor.x) * factor.y) * (1 - factor.z)
			+ (((vs((uint3)(upper_lower.x, lower.y, upper.z), v)
					- vs((uint3)(lower_lower.x, lower.y, upper.z), v))
					* (1 - factor.x)
					+ (vs((uint3)(upper_upper.x, lower.y, upper.z), v)
							- vs((uint3)(lower_upper.x, lower.y, upper.z), v))
							* factor.x) * (1 - factor.y)
					+ ((vs((uint3)(upper_lower.x, upper.y, upper.z), v)
							- vs((uint3)(lower_lower.x, upper.y, upper.z), v))
							* (1 - factor.x)
							+ (vs((uint3)(upper_upper.x, upper.y, upper.z), v)
									- vs(
											(uint3)(lower_upper.x, upper.y,
													upper.z), v)) * factor.x)
							* factor.y) * factor.z;

	gradient.y = (((vs((uint3)(lower.x, upper_lower.y, lower.z), v)
			- vs((uint3)(lower.x, lower_lower.y, lower.z), v)) * (1 - factor.x)
			+ (vs((uint3)(upper.x, upper_lower.y, lower.z), v)
					- vs((uint3)(upper.x, lower_lower.y, lower.z), v))
					* factor.x) * (1 - factor.y)
			+ ((vs((uint3)(lower.x, upper_upper.y, lower.z), v)
					- vs((uint3)(lower.x, lower_upper.y, lower.z), v))
					* (1 - factor.x)
					+ (vs((uint3)(upper.x, upper_upper.y, lower.z), v)
							- vs((uint3)(upper.x, lower_upper.y, lower.z), v))
							* factor.x) * factor.y) * (1 - factor.z)
			+ (((vs((uint3)(lower.x, upper_lower.y, upper.z), v)
					- vs((uint3)(lower.x, lower_lower.y, upper.z), v))
					* (1 - factor.x)
					+ (vs((uint3)(upper.x, upper_lower.y, upper.z), v)
							- vs((uint3)(upper.x, lower_lower.y, upper.z), v))
							* factor.x) * (1 - factor.y)
					+ ((vs((uint3)(lower.x, upper_upper.y, upper.z), v)
							- vs((uint3)(lower.x, lower_upper.y, upper.z), v))
							* (1 - factor.x)
							+ (vs((uint3)(upper.x, upper_upper.y, upper.z), v)
									- vs(
											(uint3)(upper.x, lower_upper.y,
													upper.z), v)) * factor.x)
							* factor.y) * factor.z;

	gradient.z = (((vs((uint3)(lower.x, lower.y, upper_lower.z), v)
			- vs((uint3)(lower.x, lower.y, lower_lower.z), v)) * (1 - factor.x)
			+ (vs((uint3)(upper.x, lower.y, upper_lower.z), v)
					- vs((uint3)(upper.x, lower.y, lower_lower.z), v))
					* factor.x) * (1 - factor.y)
			+ ((vs((uint3)(lower.x, upper.y, upper_lower.z), v)
					- vs((uint3)(lower.x,upper.y, lower_lower.z), v))
					* (1 - factor.x)
					+ (vs((uint3)(upper.x, upper.y, upper_lower.z), v)
							- vs((uint3)(upper.x, upper.y, lower_lower.z), v))
							* factor.x) * factor.y) * (1 - factor.z)
			+ (((vs((uint3)(lower.x, lower.y, upper_upper.z), v)
					- vs((uint3)(lower.x, lower.y, lower_upper.z), v))
					* (1 - factor.x)
					+ (vs((uint3)(upper.x, lower.y, upper_upper.z), v)
							- vs((uint3)(upper.x, lower.y, lower_upper.z), v))
							* factor.x) * (1 - factor.y)
					+ ((vs((uint3)(lower.x, upper.y, upper_upper.z), v)
							- vs((uint3)(lower.x, upper.y, lower_upper.z), v))
							* (1 - factor.x)
							+ (vs((uint3)(upper.x, upper.y, upper_upper.z), v)
									- vs(
											(uint3)(upper.x, upper.y,
													lower_upper.z), v))
									* factor.x) * factor.y) * factor.z;

	return gradient
			* (float3)(v.dim.x / v.size.x, v.dim.y / v.size.y,
					v.dim.z / v.size.z) * (0.5f * 0.00003051944088f);
}

inline float3 get_translation(	__global const  Matrix4* restrict view) {
	return (float3)(view->data[0].w, view->data[1].w, view->data[2].w);
}


inline float3 myrotate( 	__global const  Matrix4* restrict M, const float3 v) {
	return (float3)(dot((float3)(M->data[0].x, M->data[0].y, M->data[0].z), v),
			dot((float3)(M->data[1].x, M->data[1].y, M->data[1].z), v),
			dot((float3)(M->data[2].x, M->data[2].y, M->data[2].z), v));
}

float4 raycast(const Volume v, const uint2 pos, __global  const Matrix4* view,
		const float nearPlane, const float farPlane, const float step,
		const float largestep) {

	const float3 origin = get_translation(view);
	const float3 direction = myrotate(view, (float3)(pos.x, pos.y, 1.f));

	// intersect ray with a box
	//
	// www.siggraph.org/education/materials/HyperGraph/raytrace/rtinter3.htm
	// compute intersection of ray with all six bbox planes
	const float3 invR = (float3)(1.0f) / direction;
	const float3 tbot = (float3) - 1 * invR * origin;
	const float3 ttop = invR * (v.dim - origin);

	// re-order intersections to find smallest and largest on each axis
	const float3 tmin = fmin(ttop, tbot);
	const float3 tmax = fmax(ttop, tbot);

	// find the largest tmin and the smallest tmax
	const float largest_tmin = fmax(fmax(tmin.x, tmin.y), fmax(tmin.x, tmin.z));
	const float smallest_tmax = fmin(fmin(tmax.x, tmax.y),
			fmin(tmax.x, tmax.z));

	// check against near and far plane
	const float tnear = fmax(largest_tmin, nearPlane);
	const float tfar = fmin(smallest_tmax, farPlane);

	if (tnear < tfar) {
		// first walk with largesteps until we found a hit
		float t = tnear;
		float stepsize = largestep;
		float f_t = interp(origin + direction * t, v);
		float f_tt = 0;
		if (f_t > 0) { // ups, if we were already in it, then don't render anything here
			for (; t < tfar; t += stepsize) {
				f_tt = interp(origin + direction * t, v);
				if (f_tt < 0)                  // got it, jump out of inner loop
					break;
				if (f_tt < 0.8f)               // coming closer, reduce stepsize
					stepsize = step;
				f_t = f_tt;
			}
			if (f_tt < 0) {           // got it, calculate accurate intersection
				t = t + stepsize * f_tt / (f_t - f_tt);
				return (float4)(origin + direction * t, t);
			}
		}
	}

	return (float4)(0);
}


/*



__kernel void AOCraycastKernel( __global float * pos3D,  //float3
		__global float * normal,//float3
		__global short2 * v_data,
		const uint3 v_size,
		const float3 v_dim,
			__global const  Matrix4* view,
		const float nearPlane,
		const float farPlane,
		const float step,
		const float largestep ) {

	const Volume volume = {v_size, v_dim,v_data};

	const uint2 pos = (uint2) (get_global_id(0),get_global_id(1));
	const int sizex = get_global_size(0);

	const float4 hit = raycast( volume, pos, view, nearPlane, farPlane, step, largestep );
	const float3 test = as_float3(hit);

	if(hit.w > 0.0f ) {
		vstore3(test,pos.x + sizex * pos.y,pos3D);
		float3 surfNorm = grad(test,volume);
		if(length(surfNorm) == 0) {
			//float3 n =  (INVALID,0,0);//vload3(pos.x + sizex * pos.y,normal);
			//n.x=INVALID;
			vstore3((float3)(INVALID,INVALID,INVALID),pos.x + sizex * pos.y,normal);
		} else {
			vstore3(normalize(surfNorm),pos.x + sizex * pos.y,normal);
		}
	} else {
		vstore3((float3)(0),pos.x + sizex * pos.y,pos3D);
		vstore3((float3)(INVALID, INVALID, INVALID),pos.x + sizex * pos.y,normal);
	}
}
*/





__kernel void AOCrenderDepthKernel( __global uchar4 * out,
		__global float * depth,
		const float nearPlane,
		const float farPlane ) {

	const int posx = get_global_id(0);
	const int posy = get_global_id(1);
	const int sizex = get_global_size(0);
	float d= depth[posx + sizex * posy];
	if(d < nearPlane)
	vstore4((uchar4)(255, 255, 255, 0), posx + sizex * posy, (__global uchar*)out); // The forth value in uchar4 is padding for memory alignement and so it is for following uchar4 
	else {
		if(d > farPlane)
		vstore4((uchar4)(0, 0, 0, 0), posx + sizex * posy, (__global uchar*)out);
		else {
			float h =(d - nearPlane) / (farPlane - nearPlane);
			h *= 6.0f;
			const int sextant = (int)h;
			const float fract = h - sextant;
			const float mid1 = 0.25f + (0.5f*fract);
			const float mid2 = 0.75f - (0.5f*fract);
			switch (sextant)
			{
				case 0: vstore4((uchar4)(191, 255*mid1, 64, 0), posx + sizex * posy, (__global uchar*)out); break;
				case 1: vstore4((uchar4)(255*mid2, 191, 64, 0),posx + sizex * posy ,(__global uchar*)out); break;
				case 2: vstore4((uchar4)(64, 191, 255*mid1, 0),posx + sizex * posy ,(__global uchar*)out); break;
				case 3: vstore4((uchar4)(64, 255*mid2, 191, 0),posx + sizex * posy ,(__global uchar*)out); break;
				case 4: vstore4((uchar4)(255*mid1, 64, 191, 0),posx + sizex * posy ,(__global uchar*)out); break;
				case 5: vstore4((uchar4)(191, 64, 255*mid2, 0),posx + sizex * posy ,(__global uchar*)out); break;
			}
		}
	}
}

