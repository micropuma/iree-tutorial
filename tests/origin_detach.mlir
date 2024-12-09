// -----// IR Dump After DetachElementwiseFromNamedOpsPass (iree-global-opt-detach-elementwise-from-named-ops) //----- //
util.func public @matmul(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view, %arg2: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @matmul(%input0: tensor<2x2xf32>, %input1: tensor<2x2xf32>, %input2: tensor<2x2xf32>) -> (%output0: tensor<2x2xf32>)"}} {
  %cst = arith.constant 0.000000e+00 : f32
  %0 = hal.tensor.import %arg0 "input0" : !hal.buffer_view -> tensor<2x2xf32>
  %1 = hal.tensor.import %arg1 "input1" : !hal.buffer_view -> tensor<2x2xf32>
  %2 = hal.tensor.import %arg2 "input2" : !hal.buffer_view -> tensor<2x2xf32>
  %3 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%2 : tensor<2x2xf32>) outs(%2 : tensor<2x2xf32>) {
  ^bb0(%in: f32, %out: f32):
    %9 = arith.addf %in, %in : f32
    linalg.yield %9 : f32
  } -> tensor<2x2xf32>
  %4 = tensor.empty() : tensor<2x2xf32>
  %5 = linalg.fill ins(%cst : f32) outs(%4 : tensor<2x2xf32>) -> tensor<2x2xf32>
  %6 = linalg.matmul ins(%0, %1 : tensor<2x2xf32>, tensor<2x2xf32>) outs(%5 : tensor<2x2xf32>) -> tensor<2x2xf32>
  %7 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%6, %3 : tensor<2x2xf32>, tensor<2x2xf32>) outs(%5 : tensor<2x2xf32>) {
  ^bb0(%in: f32, %in_0: f32, %out: f32):
    %9 = arith.addf %in, %in_0 : f32
    linalg.yield %9 : f32
  } -> tensor<2x2xf32>
  %8 = hal.tensor.export %7 "output0" : tensor<2x2xf32> -> !hal.buffer_view
  util.return %8 : !hal.buffer_view
}