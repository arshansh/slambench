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
inline float sq(float r) {
	return r * r;
}

struct __attribute__ ((packed)) Matrix4 {
	float4 data[4];
};


inline float3 Mat4TimeFloat3(__global struct Matrix4* restrict M, float3 v) {
	return (float3)(
			dot((float3)(M->data[0].x, M->data[0].y, M->data[0].z), v)
					+ M->data[0].w,
			dot((float3)(M->data[1].x, M->data[1].y, M->data[1].z), v)
					+ M->data[1].w,
			dot((float3)(M->data[2].x, M->data[2].y, M->data[2].z), v)
					+ M->data[2].w);
}


typedef struct sVolume {
	uint3 size;
	float3 dim;
	__global short2 * data;
} Volume;

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




__kernel void AOCintegrateKernel (
		__global short2 * restrict v_data,
		const uint3 v_size,
		const float3 v_dim,
		__global const float * restrict depth,
		const uint2 depthSize,
		__global struct Matrix4* restrict invTrack,
		__global struct Matrix4* restrict  K,
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
#define INVALID -2 


typedef struct sMatrix4 {
	float4 data[4];
} Matrix4;


typedef struct sVolume {
	uint3 size;
	float3 dim;
	__global short2 * data;
} Volume;


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

inline float3 get_translation(__global const Matrix4* restrict view) {
	return (float3)(view->data[0].w, view->data[1].w, view->data[2].w);
}


inline float3 myrotate( __global  const Matrix4* restrict M, const float3 v) {
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



__kernel void AOCraycastKernel( __global float * restrict  pos3D,  //float3
		__global float * restrict normal,//float3
		__global short2 * restrict  v_data,
		const uint3 v_size,
		const float3 v_dim,
		__global const Matrix4* view,
		const float nearPlane,
		const float farPlane,
		const float step,
		const float largestep ) {

	const Volume volume = {v_size, v_dim,v_data};
	//int a=printf("value is %f ,%f ,%f,%f \n", v_size,v_dim,v_data[0].x,v_data[0].y);
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
