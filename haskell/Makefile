LLC := llc
OPT := opt

v1:
	ghcup set ghc 8.10.7
	cabal build -O2 --ghc-options="-pgmlo=${OPT} -pgmlc=${LLC}"
	cp $(shell cabal list-bin -O2 exe:haskell) ./main

strip:
	strip -s main

clean:
	rm -rf main dist-newstyle
