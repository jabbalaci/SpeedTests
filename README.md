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

## Implementations

In the implementations I tried to use the same (simple) algorithm in order
to make the comparisons as fair as possible.

All the tests were run on my home desktop machine using Linux. Execution
times are wall-clock times and they are measured with the Unix command `time`.

(Languages are ordered by their names.)

### C

* gcc (GCC) 10.1.0
* clang version 10.0.0

|          Compilation              | Runtime (sec) |
|-----------------------------------|:-------------:|
| `gcc -O2 main.c -o main -lm`      |      6.3      |
| `gcc -O3 main.c -o main -lm`      |      6.3      |
| `gcc -Ofast main.c -o main -lm`   |      6.3      |
| `clang -O2 main.c -o main -lm`    |      5.5      |
| `clang -O3 main.c -o main -lm`    |      5.5      |
| `clang -Ofast main.c -o main -lm` |      5.4      |

### C++

* g++ (GCC) 10.1.0

|          Compilation         | Runtime (sec) |
|------------------------------|:-------------:|
| `g++ -O2 main.cpp -o main`   |      6.3      |

### D

* DMD64 D Compiler v2.092.0
* LDC - the LLVM D compiler (1.21.0)

|          Compilation      | Runtime (sec) |
|---------------------------|:-------------:|
| `dmd -release -O main.d`  |     12.1      |
| `ldc2 -release -O main.d` |      5.6      |

### Dart

* Dart VM version: 2.8.3
* Node.js v14.3.0

| Execution                                      | Runtime (sec) |                    Notes                   |
|------------------------------------------------|:-------------:|--------------------------------------------|
| `dart main.dart`                               |    34.7       | executed as a script                       |
| `dart2native main.dart -o main && ./main`      |    19.9       | compiled to native code                    |
| `dart2js main.dart -o main.js && node main.js` |    18.3       | transpiled to JS and executed with Node.js |

### Nim

* Nim Compiler Version 1.2.2
* gcc (GCC) 10.1.0
* clang version 10.0.0

| Compilation                                     | Runtime (sec)  | Which C compiler used? |
|-------------------------------------------------|:--------------:|------------------------|
| `nim c -d:release main.nim`                     |      7.9       | GCC                    |
| `nim c -d:release --gc:arc main.nim`            |      7.9       | GCC                    |
| `nim c -d:danger main.nim`                      |      7.8       | GCC                    |
| `nim c --cc:clang -d:release main.nim`          |      7.5       | clang                  |
| `nim c --cc:clang -d:release --gc:arc main.nim` |      6.9       | clang                  |
| `nim c --cc:clang -d:danger --gc:arc main.nim`  |      6.5       | clang                  |
| `nim c --cc:clang -d:danger main.nim`           |      6.2       | clang                  |
| `nim c -d:danger --gc:arc main.nim`             |      5.9       | GCC                    |

### Python 3

| Execution                          | Runtime (sec)  |            Notes           |
|------------------------------------|:--------------:|----------------------------|
| `python3 ./main.py`                |    491.2       | CPython 3.8.3              |
| `pypy3 ./main.py`                  |     90.5       | Python 3.2.5 on PyPy 2.4.0 |

### Rust

* rustc 1.42.0

|          Compilation         | Runtime (sec) |
|------------------------------|:-------------:|
| `cargo build --release`      |      5.8      |

### Zig

* zig 0.6.0

|          Compilation                      | Runtime (sec) |
|-------------------------------------------|:-------------:|
| `zig build -Drelease-fast`                |      5.6      |
| `zig build -Drelease-fast -DbufferedIo`   |      5.6      |
