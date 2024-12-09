iree-compile --iree-input-type=auto \
             --mlir-print-ir-after-all  \
             tosa.mlir -o auto-input.mlir \
             2>&1 | tee auto-input.dump