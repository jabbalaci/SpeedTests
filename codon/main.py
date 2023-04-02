#!/usr/bin/env python3

"""
mypy type annotations are actually NOT necessary for Codon

If you remove the type annotations, nothing changes.
"""

from typing import List

N = 440_000_000
# N = 10_000


def is_munchausen(number: int, cache: List[int]) -> bool:
    n = number
    total = 0

    while n > 0:
        digit = n % 10
        total += cache[digit]
        if total > number:
            return False
        n = n // 10

    return total == number


def get_cache() -> List[int]:
    return [0] + [i**i for i in range(1, 9 + 1)]


def main() -> None:
    cache: List[int] = get_cache()
    for n in range(0, N):
        if is_munchausen(n, cache):
            print(n)


##############################################################################

if __name__ == "__main__":
    main()
