#!/usr/bin/env julia

const N = Ref(440_000_000)

get_cache() = ntuple(i -> i^i, 9)

function is_munchausen(number, cache)
    n = number
    total = 0

    while n > 0
        digit = mod(n, 10)
        if digit > 0
            @inbounds total += cache[digit]
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

    for n in 0:N[]
        if is_munchausen(n, cache)
            println(n)
        end
    end
end

main()
