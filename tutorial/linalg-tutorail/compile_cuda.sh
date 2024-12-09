iree-compile --iree-hal-target-backends=cuda             \
             --iree-cuda-target=sm_86 \
             static-shape.mlir -o 1Delementwise.vmfb