function [value] = saturate(range, value)
  if value > range(2) value = range(2); end
  if value < range(1) value = range(1); end