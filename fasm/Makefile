v1:
	# FASM x64, see v1 in Makefile
	cp main_x64.asm main.asm
	fasm main.asm
	rm main.asm

v2:
	# FASM x86, see v2 in Makefile
	cp main_x86.asm main.asm
	fasm main.asm
	rm main.asm

strip:
	strip -s main

clean:
	rm main
