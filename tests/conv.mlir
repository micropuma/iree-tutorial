func.func @nhwc_conv_2d(%input: tensor<1x4x5x2xf32>, %filter: tensor<1x1x2x7xf32>) -> tensor<1x4x5x7xf32> {
  %0 = tensor.empty() : tensor<1x4x5x7xf32>
  %1 = linalg.conv_2d_nhwc_hwcf {
    dilations = dense<1> : tensor<2xi64>,
    strides = dense<1> : tensor<2xi64>
  } ins (%input, %filter : tensor<1x4x5x2xf32>, tensor<1x1x2x7xf32>) outs(%0 : tensor<1x4x5x7xf32>) -> tensor<1x4x5x7xf32>
  return %1 : tensor<1x4x5x7xf32>
}

