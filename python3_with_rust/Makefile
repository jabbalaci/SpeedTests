VENV_DIR=`cat venv | head -1`

ACTIVATE=$(VENV_DIR)/bin/activate
PYTHON3=$(VENV_DIR)/bin/python3

v1:
	# see v1 in Makefile
	source $(ACTIVATE) && maturin develop --release && deactivate

run1:
	./start_v1.sh

clean:
	cargo clean
