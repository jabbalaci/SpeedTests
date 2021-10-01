import math

func get_cache(): array[10, uint32] =
  result[0] = 0
  for i in 1'u32 .. 9'u32:
    result[i] = i ^ i

const
  MAX: uint32 = 440_000_000
  cache: array[10, uint32] = get_cache()

func is_munchausen(number: uint32): bool =
  var
    n = number
    total: uint32 = 0

  while n > 0:
    let digit = n mod 10
    total += cache[digit]
    if total > number:
      return false
    n = n div 10

  total == number

proc main() =
  for i in 0'u32 ..< MAX:
    if is_munchausen(i):
      echo i

# ###########################################################################

when isMainModule:
  main()
