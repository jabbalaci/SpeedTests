LLC := llc
OPT := opt

v1:
	# basic, see v1 in Makefile
	cp main_v1.hs main.hs
	ghc -O2 main.hs
	rm main.hs

v2:
	# optimized, see v2 in Makefile
	cp main_v2.hs main.hs
	ghcup set ghc 8.10.7
	cabal build -O2 --ghc-options="-pgmlo=${OPT} -pgmlc=${LLC}"
	cp "$(shell cabal list-bin -O2 exe:haskell)" ./main
	rm main.hs

strip:
	strip -s main

clean:
	rm main main.o main.hi
	rm -rf ./dist-newstyle
