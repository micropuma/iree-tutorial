iree-compile --iree-hal-target-backends=cuda             \
             --iree-cuda-target=sm_86      \
             --mlir-elide-resource-strings-if-larger=10  \
             --mlir-print-ir-after-all  \
             matmul.mlir -o matmul.vmfb \
             2>&1 | tee output.dump