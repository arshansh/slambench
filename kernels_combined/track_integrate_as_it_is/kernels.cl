typedef struct sTrackData {
	int result;
	float error;
	float J[6];
} TrackData;


__attribute__((reqd_work_group_size(64,1,1)))
//__attribute__(  (num_simd_work_items(4))  )
//__attribute__(  (num_compute_units(2))  )

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


