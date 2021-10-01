import math

func get_cache(): array[10, uint64] =
  result[0] = 0
  for i in 1'u64 .. 9'u64:
    result[i] = i ^ i

const
  MAX: uint64 = 440_000_000
  cache: array[10, uint64] = get_cache()

func is_munchausen(number: uint64): bool =
  var
    n = number
    total: uint64 = 0

  while n > 0:
    let digit = n mod 10
    total += cache[digit]
    if total > number:
      return false
    n = n div 10

  total == number

proc main() =
  for i in 0'u64 ..< MAX:
    if is_munchausen(i):
      echo i

# ###########################################################################

when isMainModule:
  main()
