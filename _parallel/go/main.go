package main

import (
	"fmt"
	"runtime"
	"sort"
	"sync"
)

const MAX = 440_000_000

var digitPowers = [10]uint{
	0: 0,         // 0^0
	1: 1,         // 1^1
	2: 4,         // 2^2
	3: 27,        // 3^3
	4: 256,       // 4^4
	5: 3125,      // 5^5
	6: 46656,     // 6^6
	7: 823543,    // 7^7
	8: 16777216,  // 8^8
	9: 387420489, // 9^9
}

// isMunchausen checks if a number equal to the sum of the digits raised to the power of itself.
func isMunchausen(number uint) bool {
	if number == 0 {
		return true
	}
	n := number
	var total uint
	for n > 0 {
		total += digitPowers[n%10]
		if total > number {
			return false
		}
		n /= 10
	}
	return total == number
}

func main() {
	const scaleup = 88 // the number to multiply with the number of CPUs to get the number of workers to use. 88 works well on the M3.
	var (
		numWorkers = uint(runtime.NumCPU() * scaleup)
		chunkSize  = MAX / numWorkers
		wg         sync.WaitGroup
		resultCh   = make(chan uint, 4) // 4 is the buffer size, when collecting results
	)

	// Launch worker goroutines
	wg.Add(int(numWorkers))
	for workerIndex := uint(0); workerIndex < numWorkers; workerIndex++ {
		start := workerIndex * chunkSize
		end := start + chunkSize
		if workerIndex == numWorkers-1 {
			end = MAX
		}
		go func(start, end uint) {
			defer wg.Done()
			for x := start; x < end; x++ {
				if isMunchausen(x) {
					resultCh <- x
				}
			}
		}(start, end)
	}

	// Wait for the workers to complete and then close the result channel
	go func() {
		wg.Wait()
		close(resultCh)
	}()

	// Collect results until the result channel is closed
	var results []uint
	for num := range resultCh {
		results = append(results, num)
	}

	// Sort and output the results
	sort.Slice(results, func(i, j int) bool { return results[i] < results[j] })
	for _, n := range results {
		fmt.Println(n)
	}
}
