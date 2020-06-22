#!/usr/bin/env python3

N = 440000000


def is_munchausen(number, cache):
    n = number
    total = 0

    while n > 0:
        digit = n % 10
        total += cache[digit]
        if total > number:
            return False
        n = n // 10

    return total == number


def get_cache():
    cache = [0] * 10
    for i in range(1, 9+1):
        cache[i] = i ** i
    return cache


def main():
    cache = get_cache()
    for n in range(0, N):
        if n > 0 and n % 1000000 == 0:
            print("# {:,}".format(n))
        if is_munchausen(n, cache):
            print("{:,}".format(n))

##############################################################################

if __name__ == "__main__":
    main()
