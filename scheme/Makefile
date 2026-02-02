run1:
	chez --compile-imported-libraries --optimize-level 3 -q --script main.scm

run2:
	guile -s main.scm

v3:
	gambitc -:debug=pqQ0 -exe -cc-options '-O3' main.scm

run3:
	./main

# v4:
#	gambitc -:debug=pqQ0 -exe -cc clang -cc-options '-O3' main.scm

v5:
	stalin -architecture amd64 -s -On -Ot -Ob -Om -Or -dC -dH -dP\
		-copt '-O3' main.scm

run5:
	./main

v6:
	stalin -architecture amd64 -s -On -Ot -Ob -Om -Or -dC -dH -dP\
		-cc clang -copt '-O3' main.scm

run6:
	./main

run7:
	chez --optimize-level 3 -q --script main_chez_optimized.scm

clean:
	rm main main.db main.o1
