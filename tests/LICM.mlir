func.func @hoist_pack_op_with_zero_trip_check(%bound : i32, %src : tensor<100x100xf32>) -> tensor<13x13x8x8xf32> {
  %cst0 = arith.constant 0 : i32
  %cst1 = arith.constant 1 : i32
  %pad0 = arith.constant 0.0 : f32
  %init = arith.constant dense<0.0> : tensor<13x13x8x8xf32>
  %res:2 = scf.while (%iter = %cst0, %val = %init) : (i32, tensor<13x13x8x8xf32>) -> (i32, tensor<13x13x8x8xf32>) {
    %cond = arith.cmpi slt, %iter, %bound : i32
    scf.condition(%cond) %iter, %val : i32, tensor<13x13x8x8xf32>
  } do {
  ^bb0(%arg1: i32, %arg2: tensor<13x13x8x8xf32>):
    %dest = tensor.empty() : tensor<13x13x8x8xf32>
    %pack = tensor.pack %src padding_value(%pad0 : f32) inner_dims_pos = [0, 1] inner_tiles = [8, 8] into %dest : tensor<100x100xf32> -> tensor<13x13x8x8xf32>
    %add = arith.addf %arg2, %pack : tensor<13x13x8x8xf32>
    %next = arith.addi %arg1, %cst1 : i32
    scf.yield %next, %add : i32, tensor<13x13x8x8xf32>
  }
  return %res#1 : tensor<13x13x8x8xf32>
}