#map_2d_identity = affine_map<(m, n) -> (m, n)>
#map_2d_proj_first = affine_map<(m, n) -> (m)>

func.func @foo(
      %input : tensor<3x5xf32>) -> tensor<3xf32> {
  %result_empty = tensor.empty() : tensor<3xf32>
  %cst_0 = arith.constant 0.0 : f32
  %result_init = linalg.fill ins(%cst_0 : f32) outs(%result_empty : tensor<3xf32>) -> tensor<3xf32>
  %result = linalg.generic {
    indexing_maps=[
      // Indexing maps for the parameters listed in `ins(...)`
      #map_2d_identity,
      // Indexing maps for the parameters listed in `outs(...)`
      #map_2d_proj_first
    ],
    iterator_types=[
      // Rule: the i-th iterator_type corresponds to the i-th coordinate in the
      // source space of the affine_maps defined above, (m, n). So:
      "parallel",  // This refers to the `m` coordinate in the affine-maps.
                   // This is the coordinate that is preserved in the result,
                   // see the map_2d_proj_first map given above.
      "reduction" // This refers to the `n` coordinate in the affine-maps.
                  // This is the coordinate that is dropped by the map_2d_proj_first
                  // given above and thus not present in the 1D result.
    ]
  } ins(%input : tensor<3x5xf32>)
    outs(%result_init : tensor<3xf32>)
  {
    ^bb0(%input_entry : f32, %result_entry : f32):
      %add = arith.addf %input_entry, %result_entry : f32
      linalg.yield %add : f32
  }
  -> tensor<3xf32>

  return %result : tensor<3xf32>
}