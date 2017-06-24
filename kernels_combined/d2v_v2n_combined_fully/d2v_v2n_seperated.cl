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
