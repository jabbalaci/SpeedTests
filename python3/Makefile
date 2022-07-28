run1:
	python3 main.py

run2:
	pypy3 main.py

mypy:
	mypy --config-file mypy.ini *.py

v3:
	mypyc main.py
	mv main.*.so main.so

run3:
	./start_v3.sh

run4:
	python3.11 main.py

strip:
	strip -s main.so

clean:
	rm -fr ./.mypy_cache
	rm -fr ./build
	rm ./*.so
