MAX_N = 440_000_000

def is_munchausen(num)
  n = num
  total = 0
  while n > 0
    digit = n % 10
    total += $cache[digit]
    if total > num
      return false
    end
    n /= 10
  end
  return total == num
end

$cache = [0] + (1..9).map { |n| n**n }

for i in 0 .. MAX_N do
  if is_munchausen(i)
    puts i
  end
end
