# https://nim-lang.org/docs/nimc.html
#
# -d:danger	Turns off all runtime checks and turns on the optimizer.
#
# --gc:arc will enable the reference counting memory management instead of
#          the default garbage collector. This enables Nim to use heap memory
#          which is required for strings and seqs, for example.
#
# Introduction to ARC/ORC in Nim:
#     https://nim-lang.org/blog/2020/10/15/introduction-to-arc-orc-in-nim.html
#

# gcc ----------

v1:
	nim c -d:release main.nim

v2:
	nim c -d:release --gc:arc main.nim

v3:
	nim c -d:release --gc:orc main.nim

v4:
	nim c -d:danger main.nim

v5:
	nim c -d:danger --gc:arc main.nim

v6:
	nim c -d:danger --gc:orc main.nim

# clang ----------

v7:
	nim c --cc:clang -d:release main.nim

v8:
	nim c --cc:clang -d:release --gc:arc main.nim

v9:
	nim c --cc:clang -d:release --gc:orc main.nim

v10:
	nim c --cc:clang -d:danger main.nim

v11:
	nim c --cc:clang -d:danger --gc:arc main.nim

v12:
	nim c --cc:clang -d:danger --gc:orc main.nim

# ----------

strip:
	strip -s main

clean:
	rm main
