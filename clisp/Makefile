run1:
	clisp -C main.cl

compile2:
	sbcl --noinform --eval '(compile-file "main.cl")' --quit

run2:
	sbcl --script main.fasl

clean:
	rm main.fasl
