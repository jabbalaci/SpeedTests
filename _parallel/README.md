## Parallel Implementations

In the form of pull requests, I received some solutions
using parallelism. Since these players are in a different league,
I didn't mix them with single-threaded solutions.

All the tests were run on my home desktop machine (Intel Core i7-4771 CPU @ 3.50GHz with 8 CPU cores)
using Manjaro Linux. Execution times are wall-clock times and they are measured with
[hyperfine](https://github.com/sharkdp/hyperfine) (warmup runs: 1, benchmarked runs: 2).

### D

* DMD64 D Compiler v2.100.0
* LDC - the LLVM D compiler (1.29.0)
* Benchmark date: 2022-07-28 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE size (bytes) |
|-----|:---:|:---:|
| `dmd -release -O main.d` | 2.705 ± 0.003 | 1,788,176 | -- |
| `ldc2 -release -O main.d` | 0.997 ± 0.001 | 28,784 | -- |

[see source](d)


### Go

* go version go1.23.1 linux/amd64
* Benchmark date: 2024-10-09 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `go build -o main` | 1.36 ± 0.003 | 2,161,513 | 1,407,384 |

[see source](go)


### Julia

* julia version 1.7.3
* Benchmark date: 2022-07-28 [yyyy-mm-dd]

| Execution | Runtime (sec) | -- | -- |
|-----|:---:|:---:|:---:|
| `JULIA_NUM_THREADS=8 julia --startup=no main.jl` | 1.134 ± 0.009 | -- | -- |

Note: When you launch a Julia program, first it is compiled "just in time" (JIT).
It means that the execution time indicated here is actually compile time + runtime.

[see source](julia)


### Python 3 with Numba

* Python 3.12.5
* numba 0.60.0
* numpy 2.0.1
* Benchmark date: 2024-10-08 [yyyy-mm-dd]

| Execution | Runtime (sec) | -- | -- |
|-----|:---:|:---:|:---:|
| `python3 main.py` | 1.913 ± 0.007 | -- | -- |

[see source](python3_with_numba)


### Rust

* rustc 1.62.1 (e092d0b6b 2022-07-16)
* Benchmark date: 2022-07-28 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `cargo build --release` | 0.649 ± 0.001 | 4,047,744 | 444,760 |

Note: using all 8 cores.

[see source](rust)


### Swift

* Swift version 5.9.2 (swift-5.9.2-RELEASE)
* Benchmark date: 2024-02-05 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `swiftc -Ounchecked main.swift` | 0.756 ± 0.002 | 23,168 | 16,264 |

[see source](swift)
