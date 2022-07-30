MAX_N = 440_000_000

def is_munchausen(cache, num)
  n = num
  total = 0
  while n > 0
    digit = n % 10
    total += cache[digit]
    if total > num
      return false
    end
    n //= 10
  end
  return total == num
end

cache = [0] + (1..9).map { |n| n**n }

(0 .. MAX_N).each do |i|
  if is_munchausen(cache, i)
    puts i
  end
end
