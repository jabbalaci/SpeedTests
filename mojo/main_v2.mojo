"""
How to compile/run:

1.) Install magic: https://docs.modular.com/magic/
2.) Compile (This will install Mojo when run first time):
    $ magic run mojo build -o main main.mojo
3.) Run:
    $ ./main

"""

from collections import InlineArray

alias T = UInt32
alias N = 440_000_000


fn is_munchausen(number: T, cache: InlineArray[T, 10]) -> Bool:
    n = number
    total = T(0)

    while n > 0:
        digit = n % 10
        total += cache.unsafe_get(int(digit))
        if total > number:
            return False
        n //= 10

    return total == number


fn get_cache() -> InlineArray[T, 10]:
    ca = InlineArray[T, 10](0)

    @parameter
    for i in range(1, 10):
        ca.unsafe_get(i) = i**i
    return ca


fn main():
    cache = get_cache()
    for n in range(N):
        if is_munchausen(n, cache):
            print(n)
