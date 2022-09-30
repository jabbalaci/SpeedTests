package main

import (
	"fmt"
	"math"
)

const MAX = 440_000_000

func get_cache() [10]int {
	var result [10]int
	result[0] = 0
	for i := 1; i <= 9; i++ {
		result[i] = int(math.Pow(float64(i), float64(i)))
	}
	return result
}

func is_munchausen(number int, cache *[10]int) bool {
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

func main() {
	cache := get_cache()
	for i := 0; i < MAX; i++ {
		if is_munchausen(i, &cache) {
			fmt.Println(i)
		}
	}
}
