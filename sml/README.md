# FILES:

- Makefile       -- the make file
- munchausen.sml -- the main function definition
- mlton.sml      -- the mlton main file
- munchausen.mlb -- the mlton build file
- smlnj.sml      -- the smlnj build file
- README.md      -- this file

You need either mlton or smlnj or both to run the test

# MAKE COMMANDS

`make clean` to clean

`make smlnj` to use smlnj
`make mlton` to use mlton

`make smlnj-build` to build smlnj standalone image
`make mlton-build` to build mlton executable

`make smlnj-run` to run smlnj standalone image
`make mlton-run` to run mlton executable
