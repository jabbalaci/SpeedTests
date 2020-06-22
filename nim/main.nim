import
  math,
  strformat

func get_cache(): array[10, uint32] =
  for i in 1'u32 .. 9:
    result[i] = i ^ i

const
  MAX = 440_000_000'u32
  cache = get_cache()

func is_munchausen(number: uint32): bool =
  var
    n = number
    total = 0'u32

  while n > 0:
    let digit = n mod 10
    total += cache[digit]
    if total > number:
      return false
    n = n div 10

  total == number

proc main() =
  for i in 1'u32 ..< MAX:
    if (i > 0) and (i mod 1_000_000 == 0):
      echo &"# {i}"
    if is_munchausen(i):
      echo i

# ###########################################################################

when isMainModule:
  main()
