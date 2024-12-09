util.func public @generalize_op(%arg0 : tensor<?x?xf32>, %arg1 : tensor<?x?xf32>) -> tensor<?x?xf32> {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %d0 = tensor.dim %arg0, %c0 : tensor<?x?xf32>
  %d1 = tensor.dim %arg0, %c1 : tensor<?x?xf32>
  %empty = tensor.empty(%d0, %d1): tensor<?x?xf32>
  %add = linalg.add ins(%arg0, %arg1 : tensor<?x?xf32>, tensor<?x?xf32>)
      outs(%empty : tensor<?x?xf32>) -> tensor<?x?xf32>
  util.return %add : tensor<?x?xf32>
}

