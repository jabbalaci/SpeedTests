run1:
	chezscheme --compile-imported-libraries --optimize-level 3 -q main.scm

run2:
	guile main.scm

build1:
	gsc -:debug=pqQ0 -exe -cc-options '-O3' main.scm

build2:
	gsc -:debug=pqQ0 -exe -cc clang -cc-options '-O3' main.scm

build3:
	stalin -s -On -Ot -Ob -Om -Or -dC -dH -dP\
		-copt '-O3' main.scm

build4:
	stalin -s -On -Ot -Ob -Om -Or -dC -dH -dP\
		-cc clang -copt '-O3' main.scm

clean:
	rm main main.db
