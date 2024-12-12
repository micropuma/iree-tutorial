module {
  util.func public @matmul_static(%arg0: !hal.buffer_view, %arg1: !hal.buffer_view, %arg2: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub, iree.reflection = {iree.abi.declaration = "sync func @matmul_static(%input0: tensor<128x128xf32>, %input1: tensor<128x128xf32>, %input2: tensor<128x128xf32>) -> (%output0: tensor<128x128xf32>)"}} {
    %0 = hal.tensor.import %arg0 "input0" : !hal.buffer_view -> tensor<128x128xf32>
    %1 = hal.tensor.import %arg1 "input1" : !hal.buffer_view -> tensor<128x128xf32>
    %2 = hal.tensor.import %arg2 "input2" : !hal.buffer_view -> tensor<128x128xf32>
    %3 = linalg.matmul {test.attrA, test.attrC} ins(%0, %1 : tensor<128x128xf32>, tensor<128x128xf32>) outs(%2 : tensor<128x128xf32>) -> tensor<128x128xf32>
    %4 = hal.tensor.export %3 "output0" : tensor<128x128xf32> -> !hal.buffer_view
    util.return %4 : !hal.buffer_view
  }
}

