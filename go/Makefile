init:
	go mod init main

v1:
	# using int, see v1 in Makefile
	cp main_v1 main.go
	go build -o main

v2:
	# using uint and uint32, see v2 in Makefile
	cp main_v2 main.go
	go build -o main

strip:
	strip -s main

clean:
	rm main
