import nimpy
import math

func get_cache(): array[10, int] =
  result[0] = 0
  for i in 1 .. 9:
    result[i] = i ^ i

const
  cache: array[10, int] = get_cache()

func is_munchausen(number: int): bool {.exportpy.} =
  var
    n = number
    total = 0

  while n > 0:
    let digit = n mod 10
    total += cache[digit]
    if total > number:
      return false
    n = n div 10

  total == number
