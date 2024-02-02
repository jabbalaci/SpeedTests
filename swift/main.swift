let MAX : UInt32 = 440_000_000

var cache : [UInt32] = [0, 1, 4]

func is_munchausen(number : UInt32) -> Bool
{
    var n = number
    var total : UInt32 = 0
    while (n > 0)
    {
        total += cache[Int(n % 10)]
        if (total > number) {
            return false
        }
        n = n / 10
    }

    return total == number
}

for i in 3...9 {
    var power = 1
    for _ in 0..<i { power *= i }
    cache.append(UInt32(power))
}

for k in 0..<MAX where is_munchausen(number:k)
{
    print(k)
}
