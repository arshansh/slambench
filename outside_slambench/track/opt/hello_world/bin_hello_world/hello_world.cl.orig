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

__kernel void AOCvertex2normalKernel( __global float * restrict normal,    // float3
		const uint normalSize_x,
		const uint normalSize_y,
		const __global float * restrict vertex ,
		const uint vertexSize_x,
		const uint vertexSize_y  ) {  // float3

	uint2 pixel = (uint2) (get_global_id(0),get_global_id(1));

	if(pixel.x >= vertexSize_x || pixel.y >= vertexSize_y )
	return;

	//const float3 left = vertex[(uint2)(max(int(pixel.x)-1,0), pixel.y)];
	//const float3 right = vertex[(uint2)(min(pixel.x+1,vertex.size.x-1), pixel.y)];
	//const float3 up = vertex[(uint2)(pixel.x, max(int(pixel.y)-1,0))];
	//const float3 down = vertex[(uint2)(pixel.x, min(pixel.y+1,vertex.size.y-1))];

	uint2 vleft = (uint2)(max((int)(pixel.x)-1,0), pixel.y);
	uint2 vright = (uint2)(min(pixel.x+1,vertexSize_x-1), pixel.y);
	uint2 vup = (uint2)(pixel.x, max((int)(pixel.y)-1,0));
	uint2 vdown = (uint2)(pixel.x, min(pixel.y+1,vertexSize_y-1));

	const float3 left = vload3(vleft.x + vertexSize_x * vleft.y,vertex);
	const float3 right = vload3(vright.x + vertexSize_x * vright.y,vertex);
	const float3 up = vload3(vup.x + vertexSize_x * vup.y,vertex);
	const float3 down = vload3(vdown.x + vertexSize_x * vdown.y,vertex);

	if(left.z == 0 || right.z == 0|| up.z ==0 || down.z == 0) {
		//float3 n = vload3(pixel.x + normalSize_x * pixel.y,normal);
		//n.x=INVALID;
		vstore3((float3)(INVALID,INVALID,INVALID),pixel.x + normalSize_x * pixel.y,normal);
		return;
	}
	const float3 dxv = right - left;
	const float3 dyv = down - up;
	vstore3((float3) normalize(cross(dyv, dxv)), pixel.x + pixel.y * normalSize_x, normal );

}
*/

#define INVALID -2 


typedef struct sTrackData {
	int result;
	float error;
	float J[6];
} TrackData;


typedef struct sMatrix4 {
	float4 data[4];
} Matrix4;




inline float3 Mat4TimeFloat3(Matrix4 M, float3 v) {
	return (float3)(
			dot((float3)(M.data[0].x, M.data[0].y, M.data[0].z), v)
					+ M.data[0].w,
			dot((float3)(M.data[1].x, M.data[1].y, M.data[1].z), v)
					+ M.data[1].w,
			dot((float3)(M.data[2].x, M.data[2].y, M.data[2].z), v)
					+ M.data[2].w);
}

inline float3 myrotate(const Matrix4 M, const float3 v) {
	return (float3)(dot((float3)(M.data[0].x, M.data[0].y, M.data[0].z), v),
			dot((float3)(M.data[1].x, M.data[1].y, M.data[1].z), v),
			dot((float3)(M.data[2].x, M.data[2].y, M.data[2].z), v));
}

// inVertex iterate
__kernel void AOCtrackKernel (
		__global TrackData * restrict output,
		const uint2 outputSize,
		__global const float * restrict  inVertex,// float3
		const uint2 inVertexSize,
		__global const float *  restrict inNormal,// float3
		const uint2 inNormalSize,
		__global const float * restrict refVertex,// float3
		const uint2 refVertexSize,
		__global const float * restrict refNormal,// float3
		const uint2 refNormalSize,
		__global const float* restrict Ttrack_arr,
		__global const float* restrict view_arr,
		const float dist_threshold,
		const float normal_threshold
) {


	Matrix4 Ttrack;
	int j=0;
	int i=-1;
	while(j<4){
		Ttrack.data[j].x=Ttrack_arr[++i];
		Ttrack.data[j].y=Ttrack_arr[++i];
		Ttrack.data[j].z=Ttrack_arr[++i];
		Ttrack.data[j].w=Ttrack_arr[++i];
		j++;
	}



	Matrix4 view;
	int j_1=0;
	int i_1=-1;
	while(j_1<4){
		view.data[j_1].x=view_arr[++i_1];
		view.data[j_1].y=view_arr[++i_1];
		view.data[j_1].z=view_arr[++i_1];
		view.data[j_1].w=view_arr[++i_1];
		j_1++;
	}





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

