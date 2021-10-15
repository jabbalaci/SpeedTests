## Parallel Implementations

In the form of pull requests I received some solutions
using parallelism. Since these players are in a different league,
I didn't mix them with single-threaded solutions.


### D

* DMD64 D Compiler v2.092.0
* gdc (GCC) 10.1.0
* LDC - the LLVM D compiler (1.21.0)

| Compilation | Runtime (sec) | EXE size (bytes) |
|-----|:---:|:---:|
| `dmd -release -O main.d` | 3.465 ± 0.004 | 1,292,560 |
| `gdc -frelease -Ofast main.d -o main` | 2.313 ± 0.011 | 3,435,672 |
| `ldc2 -release -O main.d` | 1.921 ± 0.023 | 20,152 |

[see source](d)


### Julia

* julia version 1.6.3
* Benchmark date: 2021-10-15 [yyyy-mm-dd]

| Execution | Runtime (sec) | -- | -- |
|-----|:---:|:---:|:---:|
| `JULIA_NUM_THREADS=4 julia --startup=no main.jl` | 2.125 ± 0.013 | -- | -- |

Note: When you launch a Julia program, first it is compiled "just in time" (JIT).
It means that the execution time indicated here is actually compile time + runtime.
If we could remove the compile time, the execution time would be even better.

[see source](julia)


### Rust

* rustc 1.42.0 (b8cedc004 2020-03-09)

| Compilation | Runtime (sec) | EXE size (bytes) |
|-----|:---:|:---:|
| `cargo build --release` | 1.401 ± 0.028 | 2,817,752 |

[see source](rust)
