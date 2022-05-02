package main

import "core:fmt"

MAX :: 440_000_000

power :: proc(a: int, b: int) -> int
{
    result := 1
    for i in 1..=b {
        result *= a
    }
    return result
}

is_munchausen :: proc(number: int, cache: [10]int) -> bool
{
    n := number
    total := 0

    for n > 0
    {
        digit := n % 10
        total += cache[digit]
        if total > number {
            return false
        }
        n = n / 10
    }

    return total == number
}

main :: proc()
{
    // fill cache
    cache: [10]int
    cache[0] = 0
    for i in 1..=9 {
        cache[i] = power(i, i)
    }

    for i in 0..MAX
    {
        if is_munchausen(i, cache) {
            fmt.println(i)
        }
    }
}
