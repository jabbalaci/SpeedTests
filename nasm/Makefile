v1:
	# NASM x64, see v1 in Makefile
	cp main_x64.asm main.asm
	nasm -felf64 main.asm
	ld -m elf_x86_64 -o main main.o
	rm main.asm

v2:
	# NASM x86, see v2 in Makefile
	cp main_x86.asm main.asm
	nasm -felf32 main.asm
	ld -m elf_i386 -o main main.o
	rm main.asm

strip:
	strip -s main

clean:
	rm main main.o
