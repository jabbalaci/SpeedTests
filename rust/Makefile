v1:
	cargo build --release
	if [[ -f ./main ]]; then /bin/rm ./main; fi
	/bin/mv target/release/rust ./main

strip:
	strip -s main

clean:
	cargo clean
	rm main
