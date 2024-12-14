iree-compile --iree-hal-target-backends=cuda \
             --mlir-elide-resource-strings-if-larger=10 \
             --mlir-print-ir-after-all \
             add.mlir -o add.vmfb \
             2>&1 | tee output.dump
