return function(number, cache)
    local n = number
    local total = 0
    while n > 0 do
        total = total + cache[n % 10]
        if total > number then
            return false
        end
        n = n // 10
    end
    return total == number
end
