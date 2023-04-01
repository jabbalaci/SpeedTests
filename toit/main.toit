import math

N ::= 440000000

isMunchausen number cache -> bool:
  n := number
  total := 0

  while n > 0:
    digit := n % 10;
    total += cache[digit];
    if total > number:
      return false
    n = n / 10 // integer division
  return total == number;

getCache:
  cache := [0];
  for i := 1; i <= 9; ++i:
    cache.add (math.pow i i).to_int;
  return cache;

main:
  cache := getCache

  for i := 0; i < N; ++i:
    if isMunchausen i cache:
      print i