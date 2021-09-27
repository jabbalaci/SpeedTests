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

**2020-10-17:** After each benchmark I added some notes. These notes are specific
for this problem! It doesn't mean that you get the same performance with these
languages in all cases!

**2020-06-23:** Debug output was removed, thus the output of the programs is only 4 lines now.
All benchmarks were re-run. Lesson learned: printing to stdout is really expensive.

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

* gcc (GCC) 10.2.0
* clang version 11.1.0

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `gcc -O2 main.c -o main -lm` | 5.737 ± 0.004 | 16,224 | 14,416 |
| `clang -O2 main.c -o main -lm` | 4.463 ± 0.005 | 16,176 | 14,416 |

Note: switches `-O3` and `-Ofast` gave the same result as `-O2`, so
they were removed from the table.

Note: clang is better in this case.

[see source](c)


### C#

* .NET SDK (5.0.202)

| Compilation | Runtime (sec) | EXE (bytes) | -- |
|-----|:---:|:---:|:---:|
| `dotnet publish -o dist -c Release` | 7.893 ± 0.02 | 85,376 | -- |

Note: the runtime is about the same as Java's.

[see source](cs)


### C++

* g++ (GCC) 10.2.0
* clang version 11.1.0

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `g++ -O2 --std=gnu++2a main.cpp -o main` | 5.682 ± 0.01 | 16,736 | 14,448 |
| `clang++ -O2 --std=c++2a main.cpp -o main` | 4.86 ± 0.007 | 16,688 | 14,448 |

Note: clang is better in this case.

[see source](cpp)


### D

* DMD64 D Compiler v2.096.1
* gdc (GCC) 10.2.0
* LDC - the LLVM D compiler (1.26.0)

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `dmd -release -O main.d` | 11.344 ± 0.004 | 1,006,008 | 724,856 |
| `gdc -frelease -Ofast main.d -o main` | 5.831 ± 0.002 | 2,327,928 | 1,386,232 |
| `ldc2 -release -O main.d` | 4.83 ± 0.003 | 26,000 | 19,056 |

Note: the official compiler dmd is slow. ldc2 is the best in this case;
the runtime is comparable to C/C++.

[see source](d)


### Dart

* Dart SDK version: 2.12.4 (stable) (Thu Apr 15 12:26:53 2021 +0200) on "linux_x64"
* Node.js v16.0.0

| Execution | Runtime (sec) | compiled / transpiled output size (bytes) | -- |
|-----|:---:|:---:|:---:|
| `dart main.dart` | 30.361 ± 0.028 | -- | -- |
| `dart2native main.dart -o main && ./main` | 17.159 ± 0.008 | 5,874,944 | -- |
| `dart2js main.dart -m -o main.js && node main.js` | 17.042 ± 0.043 | 34,953 | -- |

(`*`): in the first case, the Dart code is executed as a script

Note: if you execute it as a script (JIT), it's slow.
If you compile to native code (AOT), it's still twice as slow as Java/C#.
Strangely, if you run it with Node.js, the performance is similar
to the performance of the native code.

Note: stripping caused damage to the EXE file.

[see source](dart)


### Go

* go version go1.15.6 linux/amd64

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `go build -o main` | 7.977 ± 0.007 | 2,043,716 | 1,400,152 |

Note: as fast as Java, but the EXE is huge (2 MB).

[see source](go)


### Haskell

* The Glorious Glasgow Haskell Compilation System, version 8.10.7
* Benchmark date: 2021-09-27 [yyyy-mm-dd]

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `# basic, see v1 in Makefile` | 114.913 ± 0.056 | 3,170,432 | 754,328 |
| `# optimized, see v2 in Makefile` | 5.858 ± 0.035 | 6,318,856 | 3,184,000 |

Note: the performance of the optimized version is comparable to C.
However, when you compile the optimized version for the first time,
the compilation is very slow.

[see source](haskell)


### Java

* openjdk version "11.0.8" 2020-07-14

| Execution | Runtime (sec) | Binary size (bytes) | -- |
|-----|:---:|:---:|:---:|
| `javac Main.java && java Main` | 7.852 ± 0.019 | 1,027 | -- |

(`*`): the binary size is the size of the `.class` file

Note: good performance.

[see source](java)


### Kotlin

* Kotlin version 1.4.10-release-411 (JRE 11.0.8+10)
* openjdk version "11.0.8" 2020-07-14

| Execution | Runtime (sec) | JAR size (bytes) |
|-----|:---:|:---:|
| `kotlinc main.kt -include-runtime -d main.jar && java -jar main.jar` | 7.834 ± 0.004 | 1,472,421 |

Note: same performance as Java.

[see source](kotlin)


### Lua

* Lua 5.4.0  Copyright (C) 1994-2020 Lua.org, PUC-Rio
* LuaJIT 2.0.5 -- Copyright (C) 2005-2017 Mike Pall. http://luajit.org/

| Compilation | Runtime (sec) | Notes |
|-----|:---:|:---:|
| `lua main.lua` | 146.266 ± 2.159 | -- |
| `luajit main.lua` | 22.067 ± 0.001 | -- |

Note: LuaJIT is a Just-In-Time Compiler for Lua, but it wasn't updated since 2017.
The language evolved and it contains an integer division operator (`//`), but LuaJIT
doesn't understand it.

Note: The Lua code ran much faster than the Python 3 code.

Note: LuaJIT is fast. Its performance is similar to PyPy3 (even a little bit faster).

[see source](lua)


### Nim

* Nim Compiler Version 1.4.8 [Linux: amd64]
* gcc (GCC) 10.2.0
* clang version 11.1.0

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `nim c -d:release --gc:arc main.nim` | 7.088 ± 0.01 | 56,136 | 47,264 |
| `nim c -d:release --gc:orc main.nim` | 7.082 ± 0.005 | 69,920 | 59,560 |
| `nim c -d:release main.nim` | 6.9 ± 0.01 | 84,752 | 71,960 |
| `nim c -d:danger --gc:arc main.nim` | 6.861 ± 0.111 | 42,056 | 34,976 |
| `nim c -d:danger --gc:orc main.nim` | 6.766 ± 0.004 | 51,160 | 43,176 |
| `nim c -d:danger main.nim` | 6.624 ± 0.006 | 79,800 | 67,864 |
| `nim c --cc:clang -d:release main.nim` | 6.469 ± 0.007 | 68,512 | 55,624 |
| `nim c --cc:clang -d:release --gc:arc main.nim` | 5.878 ± 0.012 | 48,048 | 39,160 |
| `nim c --cc:clang -d:release --gc:orc main.nim` | 5.877 ± 0.003 | 57,864 | 47,360 |
| `nim c --cc:clang -d:danger main.nim` | 5.655 ± 0.006 | 63,608 | 51,528 |
| `nim c --cc:clang -d:danger --gc:arc main.nim` | 5.621 ± 0.007 | 38,168 | 30,968 |
| `nim c --cc:clang -d:danger --gc:orc main.nim` | 5.607 ± 0.003 | 43,176 | 35,072 |

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


### Python 3

* Python 3.9.1
* Python 3.7.9 (?, Nov 24 2020, 10:03:59) [PyPy 7.3.3-beta0 with GCC 10.2.0]

| Compilation | Runtime (sec) | -- | -- |
|-----|:---:|:---:|:---:|
| `python3 main.py` | 392.505 ± 8.275 | -- | -- |
| `pypy3 main.py` | 24.953 ± 0.135 | -- | -- |

Note: CPython was the slowest :(

Note: PyPy3 is fast and somparable to LuaJIT.

[see source](python3)


### Rust

* rustc 1.52.1 (9bc8c42bb 2021-05-09)

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `cargo build --release` | 4.978 ± 0.021 | 3,366,800 | 289,032 |

Note: excellent performance (comparable to C/C++), but huge EXE (3 MB).
However, if you strip the EXE, the size becomes acceptable.

[see source](rust)


### V

* V 0.2.4 b72a2de

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `v -cc clang -prod main.v` | 6.282 ± 0.003 | 91,184 | 84,248 |
| `v -prod main.v` | 5.818 ± 0.013 | 97,328 | 92,376 |

By default, it uses GCC.

Note: its speed is comparable to C.

See https://vlang.io/ for more info about this language.

[see source](v)


### Zig

* zig 0.7.1

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `zig build -Drelease-fast` | 4.866 ± 0.002 | 187,288 | 9,072 |

Note: excellent performance (comparable to C/C++). The size
of the stripped exe is tiny, just 9 KB! If you want the smallest
EXE, Zig is the way.

See https://ziglang.org/ for more info about this language.

[see source](zig)
