N = 440000000

function is_munchausen(number, cache)
  local n = number
  local total = 0
  local digit = 0
  while n > 0 do
    digit = n % 10
    total = total + cache[digit]
    if total > number then
      return false
    end
    -- n = n // 10            -- LuaJIT didn't understand this
    n = math.floor(n / 10)    -- for LuaJIT, slower
  end
  return total == number
end

function get_cache()
  local cache = {}
  cache[0] = 0
  for i = 1, 9 do
    cache[i] = i ^ i
  end
  return cache
end

function main()
  local cache = get_cache()
  for n = 0, N-1 do
    if is_munchausen(n, cache) then
      print(n)
    end
  end
end

main()
