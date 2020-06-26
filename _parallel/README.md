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


### Rust

* rustc 1.42.0 (b8cedc004 2020-03-09)

| Compilation | Runtime (sec) | EXE size (bytes) |
|-----|:---:|:---:|
| `cargo build --release` | 1.401 ± 0.028 | 2,817,752 |

[see source](rust)
