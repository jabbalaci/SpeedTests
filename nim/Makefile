compile: main.nim
	nim c -d:release main.nim

# https://nim-lang.org/docs/nimc.html

# -d:danger	Turns off all runtime checks and turns on the optimizer.
danger: main.nim
	nim c -d:danger main.nim

# --gc:arc will enable the reference counting memory management instead of
#          the default garbage collector. This enables Nim to use heap memory
#          which is required for strings and seqs, for example.
arc: main.nim
	nim c -d:danger --gc:arc main.nim
