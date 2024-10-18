"""
How to compile/run:

1.) Install magic: https://docs.modular.com/magic/
2.) Compile (This will install Mojo when run first time):
    $ magic run mojo build -o main main.mojo
3.) Run:
    $ ./main

"""

alias N = 440_000_000


fn is_munchausen(number: Int32, cache: SIMD[DType.int32, 16]) -> Bool:
    var n = number
    var total: Int32 = 0

    while n > 0:
        var digit: Int32 = n % 10
        total += cache[int(digit)]
        if total > number:
            return False
        n //= 10

    return total == number

fn get_cache() -> SIMD[DType.int32, 16]:
    var ca = SIMD[DType.int32, 16](0)
    @parameter
    for i in range(1, 10):
        ca[i] = i ** 2
    return ca
    
fn main():
    var cache = get_cache()
    for n in range(0, N):
        if is_munchausen(n, cache):
            print(n)
