.PHONY: clean

all: main

main: main.go
	go build -o $@ $<

v1cp:
	# using goroutines
	cp -i main_v1 main.go

v1: v1cp main

strip: main
	strip -s main

clean:
	rm -f main
