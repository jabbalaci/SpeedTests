v1:
	zig build -Drelease-fast
	mv zig-cache/bin/app ./main

v2:
	zig build -Drelease-fast -DbufferedIo
	mv zig-cache/bin/app ./main

clean:
	rm main
	rm -fr ./zig-cache
