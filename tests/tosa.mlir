func.func @add(%lhs : tensor<12x6xf32>, %rhs : tensor<12x6xf32>) -> tensor<12x6xf32> {
  %out = tosa.add %lhs, %rhs : (tensor<12x6xf32>, tensor<12x6xf32>) -> tensor<12x6xf32>
  return %out : tensor<12x6xf32>
}