iree-run-module \
  --device=cuda \
  --module=add.vmfb \
  --function=add \
  --input="4xf32=[1 2 3 4]" \
  --input="4xf32=[2 2 2 2]"