#include <iostream>
#include <cassert>
#include <cmath> // 用于 fabs
#include <cuda_runtime.h>

#define N 500000 // Tuned such that kernel takes a few microseconds

// CUDA kernel function
__global__ void shortKernel(float *out_d, float *in_d) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < N) {
        out_d[idx] = 1.23 * in_d[idx]; // Example operation
    }
}

int main() {
    // Allocate host memory
    float *h_in = new float[N];
    float *h_out = new float[N];

    // Initialize input data on host
    for (int i = 0; i < N; ++i) {
        h_in[i] = static_cast<float>(i); // Example input: sequential numbers
    }

    // Allocate device memory
    float *d_in, *d_out;
    cudaError_t err;

    err = cudaMalloc((void**)&d_in, N * sizeof(float));
    if (err != cudaSuccess) {
        std::cerr << "CUDA malloc error for d_in: " << cudaGetErrorString(err) << std::endl;
        return -1;
    }

    err = cudaMalloc((void**)&d_out, N * sizeof(float));
    if (err != cudaSuccess) {
        std::cerr << "CUDA malloc error for d_out: " << cudaGetErrorString(err) << std::endl;
        return -1;
    }

    // Copy input data from host to device
    err = cudaMemcpy(d_in, h_in, N * sizeof(float), cudaMemcpyHostToDevice);
    if (err != cudaSuccess) {
        std::cerr << "CUDA memcpy error: " << cudaGetErrorString(err) << std::endl;
        return -1;
    }

    // Create CUDA events for timing
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    // Record start event
    cudaEventRecord(start);

    // Launch kernel with 256 threads per block and enough blocks to cover N elements
    int threadsPerBlock = 256;
    int blocksPerGrid = (N + threadsPerBlock - 1) / threadsPerBlock; // Ceil division
    shortKernel<<<blocksPerGrid, threadsPerBlock>>>(d_out, d_in);

    // Check for kernel launch errors
    err = cudaGetLastError();
    if (err != cudaSuccess) {
        std::cerr << "CUDA error: " << cudaGetErrorString(err) << std::endl;
        return -1;
    }

    // Synchronize to ensure kernel execution is complete
    cudaDeviceSynchronize();

    // Record stop event
    cudaEventRecord(stop);

    // Wait for the stop event to complete
    cudaEventSynchronize(stop);

    // Calculate elapsed time
    float elapsedTime;
    cudaEventElapsedTime(&elapsedTime, start, stop);

    std::cout << "Kernel execution time: " << elapsedTime << " ms" << std::endl;

    // Copy result back to host
    err = cudaMemcpy(h_out, d_out, N * sizeof(float), cudaMemcpyDeviceToHost);
    if (err != cudaSuccess) {
        std::cerr << "CUDA memcpy error: " << cudaGetErrorString(err) << std::endl;
        return -1;
    }

    // Verify the output with a tolerance
    for (int i = 0; i < N; ++i) {
        std::cerr << h_out[i]  << std::endl;
    }

    // Clean up
    delete[] h_in;
    delete[] h_out;
    cudaFree(d_in);
    cudaFree(d_out);

    // Destroy CUDA events
    cudaEventDestroy(start);
    cudaEventDestroy(stop);

    return 0;
}

