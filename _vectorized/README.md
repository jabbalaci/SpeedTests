## Vectorized Solutions

More info about it: https://github.com/jabbalaci/SpeedTests/pull/19

All the tests were run on my home desktop machine (Intel Core i7-4771 CPU @ 3.50GHz with 8 CPU cores)
using Manjaro Linux. Execution times are wall-clock times and they are measured with
[hyperfine](https://github.com/sharkdp/hyperfine) (warmup runs: 2, benchmarked runs: 3).


### C

* gcc (GCC) 12.1.0
* clang version 14.0.6
* Benchmark date: 2022-07-28 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `clang -O3 main.c -o main -lm -march=native` | 4.911 ± 0.1 | 24,784 | 18,520 |
| `gcc -O3 main.c -o main -lm -march=native` | 3.103 ± 0.008 | 20,744 | 14,424 |

[see source](c)
