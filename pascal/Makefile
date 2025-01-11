v1:
	# see v1 in Makefile
	cp main_v1.pas main.pas
	fpc -O3 main.pas
	rm main.pas

v2:
	# see v2 in Makefile
	cp main_v2.pas main.pas
	fpc -O3 main.pas
	rm main.pas

strip:
	strip -s main

clean:
	rm -f ./main ./*.o
