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
* clang version 11.0.0

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `gcc -O2 main.c -o main -lm` | 5.724 ± 0.003 | 16,744 | 14,336 |
| `clang -O2 main.c -o main -lm` | 4.46 ± 0.002 | 16,696 | 14,328 |

Note: switches `-O3` and `-Ofast` gave the same result as `-O2`, so
they were removed from the table.

Note: clang is better in this case.

[see source](c)


### C#

* .NET Core SDK (3.1.108)

| Compilation | Runtime (sec) | EXE (bytes) | -- |
|-----|:---:|:---:|:---:|
| `dotnet publish -o dist -c Release` | 8.082 ± 0.007 | 97,672 | -- |

Note: the runtime is about the same as Java's.

[see source](cs)


### C++

* g++ (GCC) 10.2.0
* clang version 10.0.1

| Compilation | Runtime (sec) | EXE size (bytes) |
|-----|:---:|:---:|
| `g++ -O2 --std=gnu++2a main.cpp -o main` | 5.656 ± 0.006 | 17,264 |
| `clang++ -O2 --std=c++2a main.cpp -o main` | 4.828 ± 0.001 | 17,216 |

Note: clang is better in this case.

[see source](cpp)


### D

* DMD64 D Compiler v2.093.1
* gdc (GCC) 10.2.0
* LDC - the LLVM D compiler (1.23.0)

| Compilation | Runtime (sec) | EXE size (bytes) |
|-----|:---:|:---:|
| `dmd -release -O main.d` | 12.303 ± 0.043 | 1,969,344 |
| `gdc -frelease -Ofast main.d -o main` | 5.833 ± 0.005 | 2,328,872 |
| `ldc2 -release -O main.d` | 4.835 ± 0.002 | 20,216 |

Note: the official compiler dmd is slow. ldc2 is the best in this case;
the runtime is comparable to C/C++.

[see source](d)


### Dart

* Dart SDK version: 2.9.3 (stable) (Tue Sep 8 11:21:00 2020 +0200) on "linux_x64"
* Node.js v14.12.0

| Execution | Runtime (sec) | compiled / transpiled output size (bytes) |
|-----|:---:|:---:|
| `dart main.dart` | 30.498 ± 0.016 | -- |
| `dart2native main.dart -o main && ./main` | 17.645 ± 0.156 | 5,867,712 |
| `dart2js main.dart -m -o main.js && node main.js` | 14.845 ± 0.002 | 34,790 |

(`*`): in the first case, the Dart code is executed as a script

Note: if you execute it as a script, it's slow. If you compile to native code,
it's still twice as slow as Java/C#. Strangely, if you run it with Node.js, it
gives better performance than the native code.

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

* The Glorious Glasgow Haskell Compilation System, version 8.10.2

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `ghc -O2 main.hs` | 114.908 ± 0.035 | 966,944 | 761,016 |

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

* Nim Compiler Version 1.4.0 [Linux: amd64]
* gcc (GCC) 10.2.0
* clang version 10.0.1

| Compilation | Runtime (sec) | EXE size (bytes) |
|-----|:---:|:---:|
| `nim c -d:release --gc:orc main.nim` | 7.032 ± 0.002 | 74,568 |
| `nim c -d:release --gc:arc main.nim` | 7.016 ± 0.012 | 60,784 |
| `nim c -d:release main.nim` | 6.871 ± 0.002 | 89,352 |
| `nim c -d:danger --gc:orc main.nim` | 6.754 ± 0.004 | 51,728 |
| `nim c -d:danger --gc:arc main.nim` | 6.738 ± 0.001 | 46,784 |
| `nim c -d:danger main.nim` | 6.609 ± 0.006 | 80,304 |
| `nim c --cc:clang -d:release main.nim` | 6.464 ± 0.009 | 69,040 |
| `nim c --cc:clang -d:release --gc:arc main.nim` | 5.862 ± 0.004 | 48,632 |
| `nim c --cc:clang -d:release --gc:orc main.nim` | 5.828 ± 0.005 | 58,448 |
| `nim c --cc:clang -d:danger main.nim` | 5.683 ± 0.007 | 64,136 |
| `nim c --cc:clang -d:danger --gc:orc main.nim` | 5.582 ± 0.003 | 43,776 |
| `nim c --cc:clang -d:danger --gc:arc main.nim` | 5.575 ± 0.003 | 38,832 |

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

* rustc 1.47.0 (18bf6b4f0 2020-10-07)

| Compilation | Runtime (sec) | EXE size (bytes) |
|-----|:---:|:---:|
| `cargo build --release` | 4.961 ± 0.032 | 3,185,704 |

Stripped size of the EXE: `284,832` bytes.

Note: excellent performance (comparable to C/C++), but huge EXE (3 MB).
However, if you strip the EXE, the size becomes acceptable.

[see source](rust)


### V

* V 0.2 30c0659

| Compilation | Runtime (sec) | EXE (bytes) | stripped EXE (bytes) |
|-----|:---:|:---:|:---:|
| `v -prod main.v` | 13.278 ± 0.002 | 26,352 | 22,664 |
| `v -cc clang -prod main.v` | 6.213 ± 0.003 | 43,488 | 39,048 |

Note: the default compiler is GCC. With clang we get a much better result.

See https://vlang.io/ for more info about this language.
With clang, its speed is close to C.

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
