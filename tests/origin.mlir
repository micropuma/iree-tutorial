// -----// IR Dump After RemoveZeroExtentTensorsPass (iree-global-opt-remove-zero-extent-tensors) //----- //
util.func public @matmul(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view, %arg2: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @matmul(%input0: tensor<2x2xf32>, %input1: tensor<2x2xf32>, %input2: tensor<2x2xf32>) -> (%output0: tensor<2x2xf32>)"}} {
  %0 = hal.tensor.import %arg0 "input0" : !hal.buffer_view -> tensor<2x2xf32>
  %1 = hal.tensor.import %arg1 "input1" : !hal.buffer_view -> tensor<2x2xf32>
  %2 = hal.tensor.import %arg2 "input2" : !hal.buffer_view -> tensor<2x2xf32>
  %3 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%2 : tensor<2x2xf32>) outs(%2 : tensor<2x2xf32>) {
  ^bb0(%in: f32, %out: f32):
    %6 = arith.addf %in, %in : f32
    linalg.yield %6 : f32
  } -> tensor<2x2xf32>
  %4 = linalg.matmul ins(%0, %1 : tensor<2x2xf32>, tensor<2x2xf32>) outs(%3 : tensor<2x2xf32>) -> tensor<2x2xf32>
  %5 = hal.tensor.export %4 "output0" : tensor<2x2xf32> -> !hal.buffer_view
  util.return %5 : !hal.buffer_view
}