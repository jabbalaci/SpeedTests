"""
How to compile/run:

1.) Install magic: https://docs.modular.com/magic/
2.) Compile (This will install Mojo when run first time):
    $ magic run mojo build -o main main.mojo
3.) Run:
    $ ./main

"""

alias N = 440_000_000

fn is_munchausen(number: UInt32, cache: List[UInt32]) -> Bool:
    n = number
    var total: UInt32 = 0

    while n > 0:
        digit = n % 10
        total += cache[int(digit)]
        if total > number:
            return False
        n //= 10

    return total == number

fn get_cache() -> List[UInt32]:
    ca = List[UInt32](capacity=10)
    ca.append(0)

    @parameter
    for i in range(1,10):
        ca.append(i**i)
    return ca

fn main():
    cache = get_cache()
    for n in range(0, N):
        if is_munchausen(n, cache):
            print(n)
