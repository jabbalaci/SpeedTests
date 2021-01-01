v1:
	zig build -Drelease-fast
	mv zig-cache/bin/app ./main

strip:
	strip -s main

clean:
	rm main
	rm -fr ./zig-cache
