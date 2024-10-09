.PHONY: clean strip

main: main.go
	go build -o $@ $<

v%: main_v%
	cp -i main_v$* main.go
	go build -o main main.go

bench: main
	hyperfine -w 1 -r 2 ./main

strip: main
	strip -s $<

clean:
	rm -f main
