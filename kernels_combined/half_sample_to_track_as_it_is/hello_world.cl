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





#define INVALID -2 

typedef struct sTrackData {
	int result;
	float error;
	float J[6];
} TrackData;


inline float3 Mat4TimeFloat3(__global const  Matrix4* restrict M , float3 v) {
	return (float3)(
			dot((float3)(M->data[0].x, M->data[0].y, M->data[0].z), v)
					+ M->data[0].w,
			dot((float3)(M->data[1].x, M->data[1].y, M->data[1].z), v)
					+ M->data[1].w,
			dot((float3)(M->data[2].x, M->data[2].y, M->data[2].z), v)
					+ M->data[2].w);
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
