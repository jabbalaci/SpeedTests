#!/usr/bin/env julia

N = 440_000_000

function get_cache()
    # 1^1, 2^2, ..., 9^9
    cache = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    for i in 1:9
        cache[i] = i ^ i
    end
    return cache
end

function is_munchausen(number, cache)
    n = number
    total = 0

    while n > 0
        digit = mod(n, 10)
        if digit > 0
            total += cache[digit]
        end
        if total > number
            return false
        end
        n = div(n, 10)
    end

    return total == number
end

function main()
    cache = get_cache()

    for n in 0:N
        if is_munchausen(n, cache)
            println(n)
        end
    end
end

main()
