import math

const (
    max = 440_000_000
)

fn is_munchausen(number int, cache []int) bool {
    mut n := number
    mut total := 0

    mut digit := 0
    for n > 0 {
        digit = n % 10
        total += cache[digit]
        if total > number {
            return false
        }
        n = n / 10
    }

    return total == number
}

fn get_cache() []int {
    mut cache := [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    for i in 1 .. 10 {
        cache[i] = int(math.pow(i, i))
    }
    return cache
}

fn main() {
    cache := get_cache()
    for n in 0 .. max {
        if is_munchausen(n, cache) {
            println(n)
        }
    }
}
