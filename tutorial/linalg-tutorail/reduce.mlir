#map_1d_identity = affine_map<(m) -> (m)>
#map_1d_proj_0d = affine_map<(m) -> ()>

func.func @foo(
      %input : tensor<10xf32>) -> tensor<f32> {
  %result_empty = tensor.empty() : tensor<f32>
  %cst_0 = arith.constant 0.0 : f32
  %result_init = linalg.fill ins(%cst_0 : f32) outs(%result_empty : tensor<f32>) -> tensor<f32>
  %result = linalg.generic {
    indexing_maps=[
      // Indexing maps for the parameters listed in `ins(...)`
      #map_1d_identity,
      // Indexing maps for the parameters listed in `outs(...)`
      #map_1d_proj_0d
    ],
    iterator_types=["reduction"]
  } ins(%input : tensor<10xf32>)
    outs(%result_init : tensor<f32>)
  {
    ^bb0(%input_entry : f32, %result_entry : f32):
      %add = arith.addf %input_entry, %result_entry : f32
      linalg.yield %add : f32
  }
  -> tensor<f32>

  return %result : tensor<f32>
}