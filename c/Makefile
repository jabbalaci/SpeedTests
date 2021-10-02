all:v1 v2 v1-native v2-native v3-native

v1:
	gcc -O2 main.c -o $@ -lm

v2:
	clang -O2 main.c -o $@ -lm

v1-native:
	gcc -O3 main.c -o $@ -lm -march=native

v2-native:
	clang -O2 main.c -o $@ -lm -march=native

v3-native:
	gcc -O3 main_v3.c -o $@ -lm -march=native

strip:
	strip -s v1
	strip -s v2
	strip -s v1-native
	strip -s v2-native
	strip -s v3-native

clean:
	rm v1 v2 v1-native v2-native v3-native
