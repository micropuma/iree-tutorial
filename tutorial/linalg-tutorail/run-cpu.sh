iree-run-module \
  --module=name-op.vmfb \
  --input=2x2xf32=[[1,2][3,4]] \
  --input=2x2xf32=[[1,4][3,2]] \
  --input=2x2xf32=[[0,0][0,0]]
