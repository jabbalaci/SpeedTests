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

## History

Dates are in `yyyy-mm-dd` format.

**2020-06-23:** Debug output was removed, thus the output of the programs is only 4 lines now.
All benchmarks were re-run. Lesson learned: printing to stdout is expensive.

## Implementations

In the implementations I tried to use the same (simple) algorithm in order
to make the comparisons as fair as possible.

All the tests were run on my home desktop machine (Intel Core i5-2500 CPU @ 3.30GHz)
using Linux. Execution times are wall-clock times and they are measured with the
Unix command `time`.

The following implementations were received as pull requests: D, Zig.

If you know how to make something faster, let me know!

Languages are listed in alphabetical order.

### C

* gcc (GCC) 10.1.0
* clang version 10.0.0

|          Compilation              | Runtime (sec) |
|-----------------------------------|:-------------:|
| `gcc -O2 main.c -o main -lm`      |      5.7      |
| `gcc -O3 main.c -o main -lm`      |      5.7      |
| `gcc -Ofast main.c -o main -lm`   |      5.7      |
| `clang -O2 main.c -o main -lm`    |      4.4      |
| `clang -O3 main.c -o main -lm`    |      4.4      |
| `clang -Ofast main.c -o main -lm` |      4.4      |

[see source](c)


### C++

* g++ (GCC) 10.1.0

|          Compilation         | Runtime (sec) |
|------------------------------|:-------------:|
| `g++ -O2 main.cpp -o main`   |      5.7      |

[see source](cpp)


### D

* DMD64 D Compiler v2.092.0
* LDC - the LLVM D compiler (1.21.0)
* gdc (GCC) 10.1.0

|          Compilation                   | Runtime (sec) |
|----------------------------------------|:-------------:|
| `dmd -release -O main.d`               |     10.6      |
| `gdc -frelease -Ofast main.d -o main`  |      5.6      |
| `ldc2 -release -O main.d`              |      4.9      |

[see source](d)


### Dart

* Dart VM version: 2.8.3
* Node.js v14.3.0

| Execution                                      | Runtime (sec) |                    Notes                   |
|------------------------------------------------|:-------------:|--------------------------------------------|
| `dart main.dart`                               |    30.4       | executed as a script                       |
| `dart2native main.dart -o main && ./main`      |    17.2       | compiled to native code                    |
| `dart2js main.dart -o main.js && node main.js` |    15.5       | transpiled to JS and executed with Node.js |

[see source](dart)


### Java

* java version "1.8.0_201"

|          Execution                     | Runtime (sec) |
|----------------------------------------|:-------------:|
| `javac Main.java && java Main`         |      7.9      |

[see source](java)


### Nim

* Nim Compiler Version 1.2.2
* gcc (GCC) 10.1.0
* clang version 10.0.0

| Compilation                                     | Runtime (sec)  | Which C compiler used? |
|-------------------------------------------------|:--------------:|------------------------|
| `nim c -d:release --gc:arc main.nim`            |      7.0       | GCC                    |
| `nim c -d:release main.nim`                     |      6.8       | GCC                    |
| `nim c -d:danger main.nim`                      |      6.7       | GCC                    |
| `nim c -d:danger --gc:arc main.nim`             |      6.7       | GCC                    |
| `nim c --cc:clang -d:release main.nim`          |      6.4       | clang                  |
| `nim c --cc:clang -d:release --gc:arc main.nim` |      5.9       | clang                  |
| `nim c --cc:clang -d:danger --gc:arc main.nim`  |      5.8       | clang                  |
| `nim c --cc:clang -d:danger main.nim`           |      5.6       | clang                  |

[see source](nim)


### Python 3

| Execution                          | Runtime (sec)  |            Notes           |
|------------------------------------|:--------------:|----------------------------|
| `python3 ./main.py`                |    450.4       | CPython 3.8.3              |
| `pypy3 ./main.py`                  |     77.3       | Python 3.2.5 on PyPy 2.4.0 |

[see source](python3)


### Rust

* rustc 1.42.0

|          Compilation         | Runtime (sec) |
|------------------------------|:-------------:|
| `cargo build --release`      |      5.0      |

[see source](rust)


### Zig

* zig 0.6.0

|          Compilation                      | Runtime (sec) |
|-------------------------------------------|:-------------:|
| `zig build -Drelease-fast`                |      4.9      |
| `zig build -Drelease-fast -DbufferedIo`   |      4.9      |

[see source](zig)
