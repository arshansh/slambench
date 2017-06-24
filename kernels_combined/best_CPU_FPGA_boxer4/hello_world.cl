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



__attribute__((task))
__kernel void AOChalfSampleRobustImageKernel(__global float * restrict out,
		__global const float *restrict  in,
		const uint2 inSize,
		const float e_d,
    const uint2 outSize) {

	//uint2 pixel = (uint2) (get_global_id(0),get_global_id(1));
 

  for(uint pixel_y=0;pixel_y<outSize.y;pixel_y++){
				for(uint pixel_x=0;pixel_x<outSize.x;pixel_x++){
        
          	uint2 outSize = inSize / 2;
          
          	const uint centerPixel_x = 2 * pixel_x;
            const uint centerPixel_y = 2 * pixel_y;
          
          	float sum = 0.0f;
          	float t = 0.0f;
           
            uint count=0;
            float t_array[4];
            float sum_array[4];
            
            
          	const float center = in[centerPixel_x + centerPixel_y * inSize.x];

             
             
             int i=-1;
             int j=0;
             
            #pragma unroll 
            for(int count=0;count<4;count++){
            
                if(count%2==0){
                  i++;
                  j=0;                  
                }
            
        
          			int2 from = (int2)(clamp((int2)(centerPixel_x + j, centerPixel_y + i), (int2)(0), (int2)(inSize.x - 1, inSize.y - 1)));
          			float current = in[from.x + from.y * inSize.x];
          			if(fabs(current - center) < e_d) {
          				sum_array [count] = 1.0f;
          				t_array[count] = current;
          			}
              j++;              
          	}
           
           //removing loop dependency in sum and t 
           #pragma unroll
           for(int j=0;j<4;j++){
             t += t_array[j];
             sum += sum_array [j];
           }
          	out[pixel_x + pixel_y * outSize.x] = t / sum;
        }
  }
}


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
  
    #pragma unroll 10
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
/*
typedef struct sTrackData {
	int result;
	float error;
	float J[6];
} TrackData;


__attribute__((reqd_work_group_size(64,1,1)))
//__attribute__(  (num_simd_work_items(4))  )
__attribute__(  (num_compute_units(2))  )

__kernel void AOCreduceKernel (
		__global float * restrict out,
		__global const TrackData * restrict  J,
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


  #pragma unroll
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
      #pragma unroll
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
  #pragma unroll
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