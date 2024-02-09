// let MAX: UInt32 = 10_000
let MAX: UInt32 = 440_000_000

var cache: [UInt32] = [0]

for i in 1...9 {
    var power = 1
    for _ in 0..<i { power *= i }
    cache.append(UInt32(power))
}

func is_munchausen(_ number: UInt32) -> Bool {
    var n = number
    var total: UInt32 = 0

    while n > 0 {
        total += cache[Int(n % 10)]
        if total > number {
            return false
        }
        n = n / 10
    }

    return total == number
}

func main() {
    for n in 0..<MAX where is_munchausen(n) {
        print(n)
    }
}

main()
