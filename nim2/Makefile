v1:
	# using int, see v1 in Makefile
	cp main_v1.nim main.nim
	nim c --cc:clang -d:release main.nim
	rm main.nim

v2:
	# using int64, see v2 in Makefile
	cp main_v2.nim main.nim
	nim c --cc:clang -d:release main.nim
	rm main.nim

v3:
	# using int32, see v3 in Makefile
	cp main_v3.nim main.nim
	nim c --cc:clang -d:release main.nim
	rm main.nim

v4:
	# using uint32, see v4 in Makefile
	cp main_v4.nim main.nim
	nim c --cc:clang -d:release main.nim
	rm main.nim

v5:
	# using uint64, see v5 in Makefile
	cp main_v5.nim main.nim
	nim c --cc:clang -d:release main.nim
	rm main.nim

strip:
	strip -s main

clean:
	rm main
