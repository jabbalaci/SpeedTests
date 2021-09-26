from pathlib import Path


def read_makefile(dname):
    fname = Path(dname, "Makefile")
    with open(fname) as f:
        # lines = [l for l in f.read().splitlines() if not l.lstrip().startswith("#")]
        lines = f.read().splitlines()
    #
    d = {}
    for i in range(len(lines)):
        line = lines[i]
        if line.lstrip().startswith("#"):
            continue
        # else
        if not line.startswith("\t") and line.endswith(":"):
            key = line.replace(":", "")
            d[key] = lines[i+1].lstrip()
        #
    #
    return d
