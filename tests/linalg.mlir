func.func @matmul(%a: tensor<2x2xf32>, %b: tensor<2x2xf32>, %c: tensor<2x2xf32>) -> tensor<2x2xf32> {
  %res = linalg.generic {
    indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>],
    iterator_types = ["parallel", "parallel"]}
    ins(%c: tensor<2x2xf32>) outs(%c: tensor<2x2xf32>) {
      ^bb0(%b0 : f32, %b1 : f32):
        %0 = arith.addf %b0, %b0 : f32
        linalg.yield %0 : f32
    } -> tensor<2x2xf32>
  %0 = linalg.matmul ins (%a, %b : tensor<2x2xf32>, tensor<2x2xf32>) outs(%res: tensor<2x2xf32>) -> tensor<2x2xf32>
  return %0 : tensor<2x2xf32>
}