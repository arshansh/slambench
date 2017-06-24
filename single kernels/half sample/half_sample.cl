

//very similar t o bilaterral filter kernel


__kernel void halfSampleRobustImageKernel(__global float * out,
		__global const float * in,
		const uint2 inSize,
		const float e_d,
		const int r,
		uint2 pixel,
		uint2 outSize) {

	//uint2 pixel = (uint2) (get_global_id(0),get_global_id(1));
	//uint2 outSize = inSize / 2;

	const uint2 centerPixel = 2 * pixel;

	float sum = 0.0f;
	float t = 0.0f;
	const float center = in[centerPixel.x + centerPixel.y * inSize.x];
	float current[4]; 

		for(int j = 0; j <= 4; ++j) {
			int2 from = (int2)(clamp((int2)(centerPixel.x + i, centerPixel.y + i), (int2)(0), (int2)(inSize.x - 1, inSize.y - 1)));
			current[i] = in[from.x + from.y * inSize.x];
		}
	
		#pragma unroll
		for(int j = 0; j <= 4; ++j) {
			if(fabs(current[j] - center) < e_d) {
			sum += 1.0f;
			t += current[j];
			}
		}
	out[pixel.x + pixel.y * outSize.x] = t / sum;

}
