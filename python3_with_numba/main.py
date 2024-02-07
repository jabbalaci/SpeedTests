#!/usr/bin/env python3

import numpy as np
from numba import njit

N = 440_000_000
#N = 10_000_000

cache = np.array([0] + [i ** i for i in range(1, 9+1)])

@njit
def is_munchausen(number: int) -> bool:
    n = number
    total = 0
    while n > 0:
        digit = n % 10
        total += cache[digit]
        if total > number:
            return False
        n = n // 10

    return total == number

@njit
def main() -> None:
    for n in range(0, N):
        if is_munchausen(n):
            print(n)

##############################################################################

if __name__ == "__main__":
    main()