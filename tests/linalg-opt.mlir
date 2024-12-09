#map = affine_map<(d0, d1) -> (d0, d1)>
module {
  func.func @matmul(%arg0: tensor<2x2xf32>, %arg1: tensor<2x2xf32>, %arg2: tensor<2x2xf32>) -> tensor<2x2xf32> {
    %0 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel", "parallel"]} ins(%arg2 : tensor<2x2xf32>) outs(%arg2 : tensor<2x2xf32>) {
    ^bb0(%in: f32, %out: f32):
      %1 = arith.addf %in, %in : f32
      linalg.yield %1 : f32
    } -> tensor<2x2xf32>
    return %0 : tensor<2x2xf32>
  }
}

