transpiler:
	-git clone git@github.com:thomasmueller/bau-lang.git
	-git -C bau-lang pull
	mvn -f bau-lang -DskipTests clean install

v1:
	java -jar bau-lang/target/bau-*.jar main.bau
	gcc -O3 main.c -o main

strip:
	strip -s main

run:
	./main

clean:
	rm -f main.c
	rm -f main
	rm -rf bau-lang
