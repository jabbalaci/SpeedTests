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

**2021-10-10:** Julia code was added.

## Implementations

In the implementations I tried to use the same (simple) algorithm in order
to make the comparisons as fair as possible.

All the tests were run on my home desktop machine (Intel Core i5-2500 CPU @ 3.30GHz with 4 CPU cores)
using Linux. Execution times are wall-clock times and they are measured with
[hyperfine](https://github.com/sharkdp/hyperfine) (warmup runs: 2, benchmarked runs: 3).

The following implementations were received in the form of pull requests:
D, Haskell, Lua, V, Zig.

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

* .NET SDK (5.0.205)
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | -- |
|-----|:---:|:---:|:---:|
| `dotnet publish -o dist -c Release` | 7.854 ± 0.017 | 85,376 | -- |

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


### Julia

* julia version 1.6.3
* Benchmark date: 2021-10-11 [yyyy-mm-dd]

| Execution | Runtime (sec) | -- | -- |
|-----|:---:|:---:|:---:|
| `julia main.jl` | 6.34 ± 0.009 | -- | -- |

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


### Nim Tests #1

* Nim Compiler Version 1.4.8 [Linux: amd64]
* gcc (GCC) 11.1.0
* clang version 12.0.1
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `nim c -d:release --gc:orc main.nim` | 7.008 ± 0.001 | 69,920 | 59,560 |
| `nim c -d:release --gc:arc main.nim` | 6.973 ± 0.002 | 56,136 | 47,264 |
| `nim c -d:release main.nim` | 6.829 ± 0.011 | 84,824 | 71,960 |
| `nim c -d:danger --gc:arc main.nim` | 6.707 ± 0.018 | 42,056 | 34,976 |
| `nim c -d:danger --gc:orc main.nim` | 6.707 ± 0.02 | 51,160 | 43,176 |
| `nim c -d:danger main.nim` | 6.571 ± 0.017 | 83,968 | 71,960 |
| `nim c --cc:clang -d:release main.nim` | 6.422 ± 0.018 | 68,512 | 55,624 |
| `nim c --cc:clang -d:danger --gc:orc main.nim` | 5.871 ± 0.002 | 43,176 | 35,072 |
| `nim c --cc:clang -d:release --gc:orc main.nim` | 5.823 ± 0.009 | 57,864 | 47,360 |
| `nim c --cc:clang -d:release --gc:arc main.nim` | 5.822 ± 0.021 | 48,048 | 39,160 |
| `nim c --cc:clang -d:danger main.nim` | 5.597 ± 0.017 | 63,608 | 51,528 |
| `nim c --cc:clang -d:danger --gc:arc main.nim` | 5.568 ± 0.009 | 38,168 | 30,968 |

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

* Nim Compiler Version 1.4.8 [Linux: amd64]
* gcc (GCC) 11.1.0
* clang version 12.0.1
* Benchmark date: 2021-10-01 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `# using int32, see v3 in Makefile` | 8.007 ± 0.01 | 57,864 | 47,360 |
| `# using uint64, see v5 in Makefile` | 5.889 ± 0.016 | 58,168 | 47,360 |
| `# using int64, see v2 in Makefile` | 5.879 ± 0.011 | 57,864 | 47,360 |
| `# using int, see v1 in Makefile` | 5.875 ± 0.011 | 57,864 | 47,360 |
| `# using uint32, see v4 in Makefile` | 5.052 ± 0.046 | 58,168 | 47,360 |

Here, we used the compiler options `--cc:clang -d:release --gc:orc`
everywhere and tested the different integer data types.

Note: in Nim, the size of `int` is platform-dependent, i.e. it's 64-bit long on
a 64 bit system. Thus, on a 64 bit system, there is no difference between
using int and int64 (that is, v1 and v2 are quivalent).

Note: there's no difference between int / int64 (signed) and uint64 (unsigned).

Note: int32 (v3) gave the worst performance, while uint32 (v4) produced the best result.
Using uint32 gave significantly better performance here.

[see source](nim2)


### Python 3

* Python 3.9.7
* Python 3.7.10 (77787b8f4c49115346d1e9cbaf48734137417738, Jun 13 2021, 02:02:23) [PyPy 7.3.5 with GCC 11.1.0]
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Execution | Runtime (sec) | -- | -- |
|-----|:---:|:---:|:---:|
| `python3 main.py` | 404.493 ± 6.29 | -- | -- |
| `pypy3 main.py` | 24.698 ± 0.051 | -- | -- |

Note: CPython was the slowest :(

Note: PyPy3 is fast and somparable to LuaJIT.

[see source](python3)


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

* zig 0.8.1
* Benchmark date: 2021-09-30 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `zig build-exe -OReleaseFast --single-threaded src/main.zig` | 4.873 ± 0.012 | 99,536 | 10,096 |

Note: excellent performance (comparable to C/C++). The size
of the stripped exe is tiny, just 10 KB! If you want the smallest
EXE, Zig is the way.

See https://ziglang.org for more info about this language.

[see source](zig)
