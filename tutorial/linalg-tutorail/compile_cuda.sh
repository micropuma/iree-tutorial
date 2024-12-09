iree-compile --iree-hal-target-backends=cuda \
             --iree-cuda-target=sm_86 \
             dynamic-shape.mlir -o 1Delementwise.vmfb