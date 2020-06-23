## Parallel Implementations

In the form of pull requests I received some solutions
using parallelism. Since these players are in a different league,
I didn't mix them with single-threaded solutions.

### D

* DMD64 D Compiler v2.092.0
* LDC - the LLVM D compiler (1.21.0)

|          Compilation      | Runtime (sec) |
|---------------------------|:-------------:|
| `dmd -release -O main.d`  |      5.9      |
| `ldc2 -release -O main.d` |      2.9      |
