func.func private @tensor_exp(%arg0: tensor<4xf32>) -> tensor<4xf32> {
  %res = math.exp %arg0 : tensor<4xf32>
  return %res : tensor<4xf32>
}
