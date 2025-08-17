.PHONY: clean

clean:
	rm exec.*
	rm munchausen

smlnj:
	$(MAKE) smlnj-build
	$(MAKE) smlnj-run

mlton:
	$(MAKE) mlton-build
	$(MAKE) mlton-run

smlnj-run:
	sml @SMLload=`echo exec.*`

mlton-run:
	./munchausen

mlton-build:
	mlton munchausen.mlb

smlnj-build:
	sml smlnj.sml
