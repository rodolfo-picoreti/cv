function result = map(from_range, to_range, value)
  df = from_range(2) - from_range(1);
  dt = to_range(2) - to_range(1);
  result = dt/df*(value - from_range(1)) + to_range(1);
