#!/usr/bin/env julia

const N = 440_000_000
const cache = (0, ntuple(i -> i^i, 9)...)

function is_munchausen(number)
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
    Threads.@threads for n in 0:N
        if is_munchausen(n)
            println(n)
        end
    end
end

main()
