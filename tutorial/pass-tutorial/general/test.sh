iree-opt --iree-common-input-transformation-pipeline test.mlir -o test1.mlir 
iree-opt --iree-abi-transformation-pipeline test1.mlir -o test2.mlir
iree-opt --iree-flow-transformation-pipeline test2.mlir -o test3.mlir
iree-opt --iree-stream-transformation-pipeline test3.mlir -o test4.mlir
iree-opt --iree-hal-target-backends=cuda \
         --iree-hal-cuda-llvm-target-arch=sm_86 \
         test4.mlir test5.mlir
iree-opt --iree-hal-transformation-pipeline test5.mlir -o test6.mlir