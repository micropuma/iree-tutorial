func.func @matmul(%lhs : tensor<1024x1024xf32>, %rhs : tensor<1024x1024xf32>,
                  %init : tensor<1024x1024xf32>) -> tensor<1024x1024xf32> {
  %0 = linalg.matmul
         ins(%lhs, %rhs : tensor<1024x1024xf32>, tensor<1024x1024xf32>)
         outs(%init : tensor<1024x1024xf32>) -> tensor<1024x1024xf32>
  return %0 : tensor<1024x1024xf32>
}