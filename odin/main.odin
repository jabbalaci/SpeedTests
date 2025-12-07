package main

import "core:fmt"
import "core:math"

MAX :: 440_000_000

is_munchausen :: proc "contextless" (number: int, cache: [10]int) -> bool {
    n := number
    total := 0

    for n > 0 {
        digit := n % 10
        total += cache[digit]
        if total > number {
            return false
        }
        n = n / 10
    }

    return total == number
}

cache: [10]int
main :: proc() {
    cache[0] = 0
    for i in 1 ..= 9 {
        cache[i] = int(math.pow(f64(i), f64(i)))
    }

    for i in 0 ..< MAX {
        if is_munchausen(i, cache) {
            fmt.println(i)
        }
    }
}
