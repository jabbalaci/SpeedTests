run1:
	clj -M -m main

v2:
	mkdir classes
	clj -M compile.clj

run2:
	java -cp `clj -Spath` main

clean:
	rm -rf classes/ .cpcache/
