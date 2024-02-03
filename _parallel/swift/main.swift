import Dispatch

let MAX: UInt32 = 440_000_000
let numberOfChunks = 1_000  // The number of chunks you want to split the task into
let chunkSize = MAX / UInt32(numberOfChunks)  // Calculate the chunk size based on the number of chunks
var cache: [UInt32] = [0, 1, 4]

func is_munchausen(number: UInt32) -> Bool {
    var n = number
    var total: UInt32 = 0
    while (n > 0) {
        total += cache[Int(n % 10)]
        if (total > number) {
            return false
        }
        n = n / 10
    }
    return total == number
}

// Calculate the powers once and use them in the is_munchausen check
for i in 3...9 {
    var power = 1
    for _ in 0..<i { power *= i }
    cache.append(UInt32(power))
}

func processChunk(start: UInt32, end: UInt32) async {
    for k in start..<end {
        if is_munchausen(number: k) {
            print(k)
        }
    }
}

let semaphore = DispatchSemaphore(value: 0)

Task {
    await withTaskGroup(of: Void.self) { group in
        for chunkIndex in 0..<numberOfChunks {
            let start = UInt32(chunkIndex) * chunkSize
            let end = chunkIndex == (numberOfChunks - 1) ? MAX : start + chunkSize

            group.addTask {
                await processChunk(start: start, end: end)
            }
        }
    }
    semaphore.signal()
}

semaphore.wait()
