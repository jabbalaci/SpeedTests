# Speed Tests

When I learn a new programming language, I always implement the
Münchausen numbers problem in the given language. The problem is
simple but it includes a lot of computations, thus it gives a good
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

### C

* gcc (GCC) 10.1.0

|          Compilation         | Runtime (sec) |
|------------------------------|:-------------:|
| `gcc -O2 -lm main.c -o main` |      6.3      |

### Nim

* Nim Compiler Version 1.2.2

| Compilation                          | Runtime (sec)  |
|--------------------------------------|:--------------:|
| `nim c -d:release main.nim`          |      7.9       |
| `nim c -d:release --gc:arc main.nim` |      7.9       |
| `nim c -d:danger main.nim`           |      7.8       |
| `nim c -d:danger --gc:arc main.nim`  |      5.9       |

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

### C++

* g++ (GCC) 10.1.0

|          Compilation         | Runtime (sec) |
|------------------------------|:-------------:|
| `g++ -O2 main.cpp -o main`   |      6.3      |

### Dart

* Dart VM version: 2.8.3
* Node.js v14.3.0

| Execution                                      | Runtime (sec) |            Notes           |
|------------------------------------------------|:-------------:|----------------------------|
| `dart main.dart`                               |    34.7       | executed as a script       |
| `dart2native main.dart -o main && ./main`      |    19.9       | compiled to native code    |
| `dart2js main.dart -o main.js && node main.js` |    18.3       | executed with Node.js      |

### Dependencies 

| Language |              Tools               |
|----------|:--------------------------------:|
| C        | `gcc`                            |
| C++      | `gcc`                            |
| D        | `dub`, `ldc2`                    |
| Dart     | `dart`, `dart2native`, `dart2js` |
| Nim      | `gcc`, `nim`                     |
| Python   | `python3`, `gcc`                 |
| Rust     | `cargo`, `rustc`                 |
