v1:
	nim c -d:release main.nim

v2:
	nim c -d:release --gc:arc main.nim

# https://nim-lang.org/docs/nimc.html

# -d:danger	Turns off all runtime checks and turns on the optimizer.
v3:
	nim c -d:danger main.nim

# --gc:arc will enable the reference counting memory management instead of
#          the default garbage collector. This enables Nim to use heap memory
#          which is required for strings and seqs, for example.
v4:
	nim c -d:danger --gc:arc main.nim
