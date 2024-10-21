v1:
	# using Int, see v1 in Makefile
	cp main_v1.mojo main.mojo
	magic run mojo build -o main main.mojo
	rm main.mojo

v2:
	# using UInt32, see v2 in Makefile
	cp main_v2.mojo main.mojo
	magic run mojo build -o main main.mojo
	rm main.mojo

strip:
	strip -s main

clean:
	rm main
