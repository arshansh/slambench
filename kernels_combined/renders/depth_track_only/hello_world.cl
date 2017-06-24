/*
__attribute__(  (num_simd_work_items(2))  )
__attribute__((reqd_work_group_size(80,60,1)))
__attribute__(  (num_compute_units(2))  )

*/



typedef struct sTrackData {
	int result;
	float error;
	float J[6];
} TrackData;



//__attribute__(  (num_simd_work_items(2))  )
__attribute__((reqd_work_group_size(32,24,1)))
__attribute__(  (num_compute_units(2))  )
__kernel void AOCrenderDepthTrackKernel( __global uchar4 * restrict  out_depth,
		__global float * restrict depth,
		const float nearPlane,
		const float farPlane,
   
    __global uchar3 * restrict  out_track,
    __global const TrackData * restrict data ) {

	const int posx = get_global_id(0);
	const int posy = get_global_id(1);
	const int sizex = get_global_size(0);
 
  
	float d= depth[posx + sizex * posy];
	if(d < nearPlane)
	vstore4((uchar4)(255, 255, 255, 0), posx + sizex * posy, (__global uchar*)out_depth); // The forth value in uchar4 is padding for memory alignement and so it is for following uchar4 
	else {
		if(d > farPlane)
		vstore4((uchar4)(0, 0, 0, 0), posx + sizex * posy, (__global uchar*)out_depth);
		else {
			float h =(d - nearPlane) / (farPlane - nearPlane);
			h *= 6.0f;
			const int sextant = (int)h;
			const float fract = h - sextant;
			const float mid1 = 0.25f + (0.5f*fract);
			const float mid2 = 0.75f - (0.5f*fract);
			switch (sextant)
			{
				case 0: vstore4((uchar4)(191, 255*mid1, 64, 0), posx + sizex * posy, (__global uchar*)out_depth); break;
				case 1: vstore4((uchar4)(255*mid2, 191, 64, 0),posx + sizex * posy ,(__global uchar*)out_depth); break;
				case 2: vstore4((uchar4)(64, 191, 255*mid1, 0),posx + sizex * posy ,(__global uchar*)out_depth); break;
				case 3: vstore4((uchar4)(64, 255*mid2, 191, 0),posx + sizex * posy ,(__global uchar*)out_depth); break;
				case 4: vstore4((uchar4)(255*mid1, 64, 191, 0),posx + sizex * posy ,(__global uchar*)out_depth); break;
				case 5: vstore4((uchar4)(191, 64, 255*mid2, 0),posx + sizex * posy ,(__global uchar*)out_depth); break;
			}
		}
	}
 
  //render track
 	switch(data[posx + sizex * posy].result) {
		// The forth value in uchar4 is padding for memory alignement and so it is for following uchar4
		case  1: vstore4((uchar4)(128, 128, 128, 0), posx + sizex * posy, (__global uchar*)out_track); break; // ok	 GREY
		case -1: vstore4((uchar4)(000, 000, 000, 0), posx + sizex * posy, (__global uchar*)out_track); break; // no input BLACK
		case -2: vstore4((uchar4)(255, 000, 000, 0), posx + sizex * posy, (__global uchar*)out_track); break; // not in image RED
		case -3: vstore4((uchar4)(000, 255, 000, 0), posx + sizex * posy, (__global uchar*)out_track); break; // no correspondence GREEN
		case -4: vstore4((uchar4)(000, 000, 255, 0), posx + sizex * posy, (__global uchar*)out_track); break; // too far away BLUE
		case -5: vstore4((uchar4)(255, 255, 000, 0), posx + sizex * posy, (__global uchar*)out_track); break; // wrong normal YELLOW
		default: vstore4((uchar4)(255, 128, 128, 0), posx + sizex * posy, (__global uchar*)out_track); return;
	}
}


