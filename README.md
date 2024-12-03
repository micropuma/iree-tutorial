# IREE-tutorial
## Build and Test
```shell
cmake -G Ninja -B ../iree-build/ -S . \
    -DIREE_TARGET_BACKEND_DEFAULTS=OFF \
    -DIREE_TARGET_BACKEND_LLVM_CPU=ON \
    -DIREE_HAL_DRIVER_DEFAULTS=OFF \
    -DIREE_HAL_DRIVER_LOCAL_SYNC=ON \
    -DIREE_HAL_DRIVER_LOCAL_TASK=ON
```

```shell
ctest --test-dir ../iree-build/
```

上述的test遇到没有支持的硬件会自行跳过。

`../iree-build/tools/iree-compile ../iree-build/tools/iree-run-module`

这两个工具是IREE项目的核心工具。
### Try Cuda
参考[IREE Cuda](https://iree.dev/guides/deployment-configurations/gpu-cuda/#download-the-compiler-from-a-release)

下面的build选项enable了cuda。

```shell
cmake -G Ninja -B ../iree-cuda/ -S . \
    -DIREE_TARGET_BACKEND_CUDA=ON \
    -Wno-error \
    -DIREE_HAL_DRIVER_CUDA=ON \
    -DIREE_CUDA_LIBDEVICE_PATH=/usr/local/cuda-12.1/nvvm/libdevice/libdevice.10.bc
```

> IREE的官方文档有问题，本地需要指定选用的`DIREE_CUDA_LIBDEVICE_PATH`的路径。


IREE项目有三个重要工具：

1. importer，将pytorch或是tensorflow模型转成mlir。
2. iree-compile，将mlir转成vmfb。
3. iree-runtime，提供运行时支持。

上述三类工具合力协作，完成**端到端任务**。

## References
1. [IREE docs](https://iree.dev/building-from-source/getting-started/)
2. [GPU guide](https://iree.dev/guides/deployment-configurations/gpu-cuda/#compile-and-run-a-program-model)