util.func public @generic_fill(%arg0: tensor<?x?xf32>) -> tensor<1x1x?x?xf32> {
    %cst = arith.constant 0.000000e+00 : f32
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?xf32>
    %0 = tensor.empty(%dim, %dim_0) : tensor<1x1x?x?xf32>
    %1 = linalg.generic {
        indexing_maps = [affine_map<(d0, d1, d2, d3) -> (d0, d1, d2, d3)>],
        iterator_types = ["parallel", "parallel", "parallel", "parallel"]}
        outs(%0 : tensor<1x1x?x?xf32>) {
      ^bb0(%out: f32):
        linalg.yield %cst : f32
    } -> tensor<1x1x?x?xf32>
    util.return %1 : tensor<1x1x?x?xf32>
}