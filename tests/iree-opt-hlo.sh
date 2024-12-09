# 执行模型，指定后端为 vmvx
iree-run-mlir --Xcompiler,iree-input-type=stablehlo --Xcompiler,iree-hal-target-backends=vmvx fullyconnected.mlir --input=1x5xf32=1,-2,-3,4,-5 --input=1x5x3x1xf32=15,14,13,12,11,10,9,8,7,6,5,4,3,2,1 

