package main

import (
	"fmt"
	"math"
)

const MAX = 440_000_000

func get_cache() [10]uint32 {
	var result [10]uint32
	for i := 1; i <= 9; i++ {
		result[i] = uint32(math.Pow(float64(i), float64(i)))
	}
	return result
}

func is_munchausen(number uint, cache *[10]uint32) bool {
	n := number
	var total uint
	for n > 0 {
		total += uint(cache[n%10])
		if total > number {
			return false
		}
		n /= 10
	}
	return total == number
}

func main() {
	cache := get_cache()
	for i := uint(0); i < MAX; i++ {
		if is_munchausen(i, &cache) {
			fmt.Println(i)
		}
	}
}
