#!/usr/bin/env julia

const N = 440_000_000

get_cache() = (0, ntuple(i -> i^i, 9)...)

function is_munchausen(number, cache)
    n = number
    total = 0

    while n > 0
        (n, digit) = divrem(n, 10)
        @inbounds total += cache[digit+1]
        if total > number
            return false
        end
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
