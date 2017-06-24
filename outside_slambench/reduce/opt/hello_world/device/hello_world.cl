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
