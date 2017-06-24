# slambench

This folder contains all the work done for my Final year project: Evaluation of hardware accelerated SLAM algorithms.
The project has evaluated the performance of the SLAMBench SLAM algorithm (kinectFusion) on an FPGA device using OpenCL.
this repository containts details of the implementations, and is referenced in my thesis a lot. In order to fully understand what each folder contains, I definitely recommend reading my thesis first.  

If there are any questions please email me at : sh_arsh2000@yahoo.com

What each folder contains:
1)Balanced_floating_point: These are a set of kernels compiled with Intel FPGA SDK floationg point optimization flags.

2)channels: This folder contains opportunities of where Intel OpenCL channels can be used inKinectFusion kernels.

3)gpu_slambench: This folder is just like the PAMELA SLAMBench repository, with clear instructions of how to compile and build SLAMBench.

4)kernels_combined: This folder contrains detailed implmenetations of the combined kernels in SLAMBench for FPGAs.

5)slambench: This is a very IMPORTANT folder. For future work on SLAMBench FPGAs, this folder is tuned and ready to run OpenCL on FPGA. All that needs to be done, it pasting the ".aocx" file in kfusion/build once the application is built. The compiled kernel name should also be added to the host.

6)single kernels: This folder contains for every single kernel, the GPU OpenCL, CPU C++, FPGA unoptimized and FPGA optimized implmentation.

7)outside_slambench: this folder contains all the work done for implementing SLAMBench for FPGAs outside the SLAMBench framwork (by reading I/O text files from SLAMBench) for every single kernel.
