# Speed Tests

When I learn a new programming language, I always implement the
Münchausen numbers problem in the given language. The problem is
simple but it includes a lot of computations, thus it gives an
idea of the execution speed of a language.

## Münchausen numbers

A [Münchausen number](https://en.wikipedia.org/wiki/Perfect_digit-to-digit_invariant)
is a number equal to the sum of its digits raised to each digit's power.

For instance, 3435 is a Münchausen number because
3<sup>3</sup>+4<sup>4</sup>+3<sup>3</sup>+5<sup>5</sup> = 3435.

0<sup>0</sup> is not well-defined, thus we'll consider 0<sup>0</sup>=0.
In this case there are four Münchausen numbers: 0, 1, 3435, and 438579088.

## Exercise

Write a program that finds all the Münchausen numbers. We know that the largest
Münchausen number is less than 440 million.

## Updates

Dates are in `yyyy-mm-dd` format.

**2022-05-02:** Odin code was added.

**2022-05-02:** Elixir code was added.

## Implementations

In the implementations I tried to use the same (simple) algorithm in order
to make the comparisons as fair as possible.

All the tests were run on my home desktop machine (Intel Core i5-2500 CPU @ 3.30GHz with 4 CPU cores)
using Linux. Execution times are wall-clock times and they are measured with
[hyperfine](https://github.com/sharkdp/hyperfine) (warmup runs: 2, benchmarked runs: 3).

The following implementations were received in the form of pull requests:
D, FASM, Haskell, Lua, NASM, Racket, JavaScript, V, Zig. Thanks for the contributions!

If you know how to make something faster, let me know!

Languages are listed in alphabetical order.

The size of the EXE files can be further reduced with the command `strip -s`. If it's
applicable, then the stripped EXE size is also shown in the table.


### C

* gcc (GCC) 11.1.0
* clang version 12.0.1
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `gcc -O2 main.c -o main -lm` | 5.667 ± 0.014 | 16,224 | 14,416 |
| `clang -O2 main.c -o main -lm` | 4.382 ± 0.004 | 16,176 | 14,416 |

Note: switches `-O3` and `-Ofast` gave the same result as `-O2`, so
they were removed from the table.

Note: clang is better in this case.

[see source](c)


### C#

* .NET SDK (6.0.100)
* Benchmark date: 2021-11-20 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | -- |
|-----|:---:|:---:|:---:|
| `dotnet publish -o dist -c Release` | 8.193 ± 0.006 | 81,280 | -- |

Note: the runtime is about the same as Java's.

[see source](cs)


### C++

* g++ (GCC) 11.1.0
* clang version 12.0.1
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `g++ -O2 --std=gnu++2a main.cpp -o main` | 5.624 ± 0.013 | 16,736 | 14,448 |
| `clang++ -O2 --std=c++2a main.cpp -o main` | 4.547 ± 0.019 | 16,688 | 14,448 |

Note: clang is better in this case.

[see source](cpp)


### D

* DMD64 D Compiler v2.097.2
* gdc (GCC) 11.1.0
* LDC - the LLVM D compiler (1.27.1)
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `dmd -release -O main.d` | 10.873 ± 0.04 | 970,056 | 699,768 |
| `gdc -frelease -Ofast main.d -o main` | 5.754 ± 0.026 | 2,236,664 | 1,457,008 |
| `ldc2 -release -O main.d` | 4.835 ± 0.018 | 26,120 | 19,072 |

Note: the official compiler dmd is slow. ldc2 is the best in this case;
the runtime is comparable to C/C++.

[see source](d)


### Dart

* Dart SDK version: 2.14.2 (stable) (Wed Sep 15 12:32:06 2021 +0200) on "linux_x64"
* Node.js v16.10.0
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Execution | Runtime (sec) | compiled / transpiled output size (bytes) | -- |
|-----|:---:|:---:|:---:|
| `dart main.dart` | 30.07 ± 0.024 | -- | -- |
| `dart2js main.dart -m -o main.js && node main.js` | 16.978 ± 0.016 | 33,028 | -- |
| `dart2native main.dart -o main && ./main` | 13.91 ± 0.034 | 5,877,024 | -- |

(`*`): in the first case, the Dart code is executed as a script

Note: if you execute it as a script (JIT), it's slow.
If you compile to native code (AOT), it's about twice as slow as Java/C#.

Note: stripping caused damage to the EXE file.

[see source](dart)


### Elixir

* Erlang/OTP 24 [erts-12.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [jit]; Elixir 1.13.2 (compiled with Erlang/OTP 24)
* Benchmark date: 2022-05-02 [yyyy-mm-dd]

| Execution | Runtime (sec) | -- | -- |
|-----|:---:|:---:|:---:|
| `elixir main.exs` | 288.228 ± 0.5 | -- | -- |
| `elixirc munchausen.ex && elixir caller.exs` | 278.043 ± 2.714 | -- | -- |

Notes:

* Elixir doesn't excel in CPU-intensive tasks
* In the second case, the modules were compiled to `.beam` files. However, it
  didn't make the program much faster. The diference is very small.

[see source](elixir)


### FASM

* flat assembler  version 1.73.27
* Benchmark date: 2022-01-02 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `# FASM x64, see v1 in Makefile` | 17.684 ± 0.002 | 532 | 532 |
| `# FASM x86, see v2 in Makefile` | 17.527 ± 0.014 | 444 | 444 |

Note: no difference between the 32-bit and 64-bit versions.

See https://en.wikipedia.org/wiki/FASM for more info about FASM.

[see source](fasm)


### Go

* go version go1.17.1 linux/amd64
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `go build -o main` | 8.116 ± 0.008 | 1,779,760 | 1,208,856 |

Note: as fast as Java, but the EXE is huge (1.8 MB).

[see source](go)


### Haskell

* The Glorious Glasgow Haskell Compilation System, version 8.10.7
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `# basic, see v1 in Makefile` | 113.962 ± 0.128 | 3,170,432 | 754,328 |
| `# optimized, see v2 in Makefile` | 5.836 ± 0.015 | 6,318,856 | 3,184,000 |

Note: the performance of the optimized version is comparable to C.
However, when you compile the optimized version for the first time,
the compilation is very slow.

[see source](haskell)


### Java

* openjdk version "11.0.12" 2021-07-20
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Execution | Runtime (sec) | Binary size (bytes) | -- |
|-----|:---:|:---:|:---:|
| `javac Main.java && java Main` | 7.768 ± 0.02 | 1,027 | -- |

(`*`): the binary size is the size of the `.class` file

Note: good performance.

[see source](java)


### JavaScript

* Node.js v16.10.0
* Benchmark date: 2021-10-16 [yyyy-mm-dd]

| Execution | Runtime (sec) | -- | -- |
|-----|:---:|:---:|:---:|
| `node main.js` | 19.762 ± 0.015 | -- | -- |

[see source](javascript)


### Julia

* julia version 1.7.0
* Benchmark date: 2021-12-02 [yyyy-mm-dd]

| Execution | Runtime (sec) | -- | -- |
|-----|:---:|:---:|:---:|
| `julia --startup=no main.jl` | 5.957 ± 0.012 | -- | -- |

Note: excellent performance, almost like C.

See https://julialang.org for more info about this language.

[see source](julia)


### Kotlin

* Kotlin version 1.5.31-release-548 (JRE 11.0.12+7)
* openjdk version "11.0.12" 2021-07-20
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Execution | Runtime (sec) | JAR size (bytes) | -- |
|-----|:---:|:---:|:---:|
| `kotlinc main.kt -include-runtime -d main.jar && java -jar main.jar` | 7.997 ± 0.013 | 4,558,190 | -- |

Note: same performance as Java.

[see source](kotlin)


### Lua

* Lua 5.4.3  Copyright (C) 1994-2021 Lua.org, PUC-Rio
* LuaJIT 2.0.5 -- Copyright (C) 2005-2017 Mike Pall. http://luajit.org/
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Compilation | Runtime (sec) | -- | -- |
|-----|:---:|:---:|:---:|
| `lua main.lua` | 151.179 ± 3.367 | -- | -- |
| `luajit main.lua` | 21.92 ± 0.001 | -- | -- |

Note: LuaJIT is a Just-In-Time Compiler for Lua, but it wasn't updated since 2017.
The language evolved and it contains an integer division operator (`//`), but LuaJIT
doesn't understand it.

Note: The Lua code ran much faster than the Python 3 code.

Note: LuaJIT is fast. Its performance is similar to PyPy3 (even a little bit faster).

[see source](lua)


### NASM

* NASM version 2.15.05 compiled on Sep 24 2020
* Benchmark date: 2021-10-12 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `# NASM x86, see v2 in Makefile` | 17.536 ± 0.032 | 9,228 | 8,428 |
| `# NASM x64, see v1 in Makefile` | 17.522 ± 0.008 | 9,656 | 8,552 |

Note: no difference between the 32-bit and 64-bit versions.

See https://en.wikipedia.org/wiki/Netwide_Assembler for more info about NASM.

[see source](nasm)


### Nim Tests #1

* Nim Compiler Version 1.6.6 [Linux: amd64]
* gcc (GCC) 11.2.0
* clang version 13.0.1
* Benchmark date: 2022-05-22 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `nim c -d:release main.nim` | 7.141 ± 0.075 | 88,208 | 76,056 |
| `nim c -d:release --gc:orc main.nim` | 7.008 ± 0.003 | 68,400 | 59,568 |
| `nim c -d:release --gc:arc main.nim` | 6.997 ± 0.006 | 55,168 | 47,272 |
| `nim c -d:danger --gc:arc main.nim` | 6.734 ± 0.001 | 45,512 | 39,080 |
| `nim c -d:danger --gc:orc main.nim` | 6.725 ± 0.002 | 50,424 | 43,184 |
| `nim c -d:danger main.nim` | 6.617 ± 0.004 | 87,312 | 76,056 |
| `nim c --cc:clang -d:release main.nim` | 6.491 ± 0.001 | 76,008 | 63,752 |
| `nim c --cc:clang -d:release --gc:arc main.nim` | 5.871 ± 0.005 | 47,112 | 39,096 |
| `nim c --cc:clang -d:release --gc:orc main.nim` | 5.834 ± 0.002 | 56,328 | 47,296 |
| `nim c --cc:clang -d:danger main.nim` | 5.677 ± 0.01 | 62,544 | 51,464 |
| `nim c --cc:clang -d:danger --gc:arc main.nim` | 5.59 ± 0.003 | 37,456 | 30,904 |
| `nim c --cc:clang -d:danger --gc:orc main.nim` | 5.587 ± 0.003 | 42,360 | 35,008 |

(`*`): if `--cc:clang` is missing, then the default `gcc` was used

Note: in this case, clang gave better results than gcc.

Note: danger mode gave a very little performance boost (with clang).

Note: the new garbage collectors (ARC and ORC) perform better than
the default garbage collector (with clang). The difference between
ARC and ORC is very little. If you have cyclic references, ORC is
the suggested garbage collector. Since the difference is so small,
and ORC is more general, maybe it's better to use ORC.

Note: to sum up, `--cc:clang -d:release --gc:orc` seems safe and fast.

[see source](nim)


### Nim Tests #2

* Nim Compiler Version 1.6.6 [Linux: amd64]
* gcc (GCC) 11.2.0
* clang version 13.0.1
* Benchmark date: 2022-05-22 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `# using uint64, see v5 in Makefile` | 6.211 ± 0.01 | 56,376 | 47,296 |
| `# using int, see v1 in Makefile` | 6.133 ± 0.002 | 56,328 | 47,296 |
| `# using int64, see v2 in Makefile` | 6.13 ± 0.004 | 56,328 | 47,296 |
| `# using int32, see v3 in Makefile` | 5.885 ± 0.004 | 56,328 | 47,296 |
| `# using uint32, see v4 in Makefile` | 5.253 ± 0.003 | 56,376 | 47,296 |

Here, we used the compiler options `--cc:clang -d:release --gc:orc`
everywhere and tested the different integer data types.

Note: in Nim, the size of `int` is platform-dependent, i.e. it's 64-bit long on
a 64 bit system. Thus, on a 64 bit system, there is no difference between
using int and int64 (that is, v1 and v2 are quivalent).

Note: there's almost no difference between int / int64 (signed) and uint64 (unsigned).

Note: int32 (v3) gave better performance than int64, and uint32 (v4) produced the best result.

[see source](nim2)


### Odin

* odin version dev-2022-04-nightly:59025b75
* Benchmark date: 2022-05-02 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `odin build main.odin -no-bounds-check -disable-assert -opt:2` | 8.669 ± 0.003 | 199,776 | 194,000 |

See https://odin-lang.org for more info about this language.

Note: good performance, though a bit slower than C.

[see source](odin)


### Python 3

* Python 3.10.4
* Python 3.8.13 (4b1398fe9d76ad762155d03684c2a153d230b2ef, Apr 02 2022, 15:38:25) [PyPy 7.3.9 with GCC 11.2.0]
* mypy 0.942
* Benchmark date: 2022-04-30 [yyyy-mm-dd]

| Execution | Runtime (sec) | -- | -- |
|-----|:---:|:---:|:---:|
| `python3 main.py` | 401.562 ± 7.186 | -- | -- |
| `mypyc main.py && ./start_v3.sh` | 89.722 ± 0.269 | -- | -- |
| `pypy3 main.py` | 25.902 ± 0.537 | -- | -- |

Notes:

* CPython was the slowest :(
* mypyc can compile a module
* PyPy3 is fast and comparable to LuaJIT

[see source](python3)


### Racket

* Welcome to Racket v8.2 [cs].
* Benchmark date: 2021-10-12 [yyyy-mm-dd]

| Execution | Runtime (sec) | -- | -- |
|-----|:---:|:---:|:---:|
| `racket main.rkt` | 132.906 ± 0.092 | -- | -- |

See https://racket-lang.org for more info about this language.

[see source](racket)


### Rust

* rustc 1.55.0 (c8dfcfe04 2021-09-06)
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `cargo build --release` | 4.952 ± 0.015 | 3,407,472 | 272,648 |

Note: excellent performance (comparable to C/C++), but huge EXE (3 MB).
However, if you strip the EXE, the size becomes acceptable.

[see source](rust)


### V

* V 0.2.4 b72a2de
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `v -cc clang -prod main.v` | 6.195 ± 0.008 | 91,184 | 84,248 |
| `v -prod main.v` | 5.743 ± 0.003 | 97,328 | 92,376 |

By default, it uses GCC.

Note: its speed is comparable to C.

See https://vlang.io for more info about this language.

[see source](v)


### Zig

* zig 0.9.0
* Benchmark date: 2022-04-01 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `zig build-exe -OReleaseFast src/main.zig` | 4.889 ± 0.001 | 105,096 | 10,256 |

Note: excellent performance (comparable to C/C++). The size
of the stripped exe is tiny, just 10 KB! If you want the smallest
EXE, Zig is the way.

See https://ziglang.org for more info about this language.

[see source](zig)
