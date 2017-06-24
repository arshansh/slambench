#pragma OPENCL_EXTENSION cl_altera_channels : enable


channel float vtx;
//channel float scld_dpth1  __attribute__((depth(19200)));
//channel float scld_dpth2  __attribute__((depth(4800)));




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


inline float3 myrotate(__global const Matrix4 * restrict M, const float3 v) {
	return (float3)(dot((float3)(M->data[0].x, M->data[0].y, M->data[0].z), v),
			dot((float3)(M->data[1].x, M->data[1].y, M->data[1].z), v),
			dot((float3)(M->data[2].x, M->data[2].y, M->data[2].z), v));
}



__attribute__(  (num_simd_work_items(2))  )
__attribute__((reqd_work_group_size(80,60,1)))
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


