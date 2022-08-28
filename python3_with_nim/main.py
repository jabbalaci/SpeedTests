#!/usr/bin/env python3

import nimporter

from nmunch import is_munchausen

N = 440_000_000
# N = 10_000


def main():
    for n in range(0, N):
        if is_munchausen(n):
            print(n)

##############################################################################

if __name__ == "__main__":
    main()
