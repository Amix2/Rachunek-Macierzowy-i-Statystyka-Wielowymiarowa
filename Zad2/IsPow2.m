function ret = IsPow2(a)
  ret = bitand(a,a-1) == 0;