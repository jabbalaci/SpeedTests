main: src/main.zig
	zig build-exe -OReleaseFast --strip --single-threaded $^
	strip -s $@

clean:
	rm main
.PHONY: clean
