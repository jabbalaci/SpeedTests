import math

func get_cache(): array[10, int32] =
  result[0] = 0
  for i in 1'i32 .. 9'i32:
    result[i] = i ^ i

const
  MAX: int32 = 440_000_000
  cache: array[10, int32] = get_cache()

func is_munchausen(number: int32): bool =
  var
    n = number
    total: int32 = 0

  while n > 0:
    let digit = n mod 10
    total += cache[digit]
    if total > number:
      return false
    n = n div 10

  total == number

proc main() =
  for i in 0'i32 ..< MAX:
    if is_munchausen(i):
      echo i

# ###########################################################################

when isMainModule:
  main()
