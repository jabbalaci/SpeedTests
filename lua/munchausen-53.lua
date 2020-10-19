return function(number, cache)
  local n = number
  local total = 0
  while n > 0 do
    local digit = n % 10
    total = total + cache[digit]
    if total > number then
      return false
    end
    n = n // 10
  end
  return total == number
end
