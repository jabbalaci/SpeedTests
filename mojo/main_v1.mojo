"""
How to compile/run:

1.) Install magic: https://docs.modular.com/magic/
2.) Compile (This will install Mojo when run first time):
    $ magic run mojo build -o main main.mojo
3.) Run:
    $ ./main

"""

alias N = 440_000_000


fn is_munchausen(number: Int, cache: List[Int]) -> Bool:
    n = number
    total = 0

    while n > 0:
        digit = n % 10
        total += cache[digit]
        if total > number:
            return False
        n //= 10

    return total == number


fn get_cache() -> List[Int]:
    ca = List[Int](capacity=10)
    ca.append(0)

    @parameter
    for i in range(1, 10):
        ca.append(i**i)
    return ca


fn main():
    cache = get_cache()
    for n in range(N):
        if is_munchausen(n, cache):
            print(n)
