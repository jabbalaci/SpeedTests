from lib.process import get_simple_cmd_output_lines


def get_version_string(name):
    if name in (
        "chez",
        "clang",
        "clang++",
        "clisp",
        "clj",
        "codon",
        "dart",
        "dmd",
        "dotnet",
        "g++",
        "gcc",
        "gdc",
        "gfortran",
        "ghc",
        "guile",
        "julia",
        "mypyc",
        "nasm",
        "nim",
        "ocamlopt",
        "python3",
        "python3.11",
        "racket",
        "ruby",
        "rustc",
        "sbcl",
        "swiftc",
    ):
        cmd = f"{name} --version"
        result = get_simple_cmd_output_lines(cmd)[0].strip()
        if name in ("chez", "codon", "dotnet", "ocamlopt"):
            result = f"{name} {result}"
        #
        return result
    if name == "ldc2":
        cmd = f"{name} --version"
        return get_simple_cmd_output_lines(cmd)[0].replace(":", "")
    if name == "toit":
        cmd = "toit.run --version"
        return get_simple_cmd_output_lines(cmd)[0].strip()
    if name in ("java", "kotlin", "v"):
        cmd = f"{name} -version"
        return get_simple_cmd_output_lines(cmd)[0]
    if name in ("go", "odin"):
        cmd = f"{name} version"
        return get_simple_cmd_output_lines(cmd)[0]
    if name in ("lua", "luajit", "fpc"):
        cmd = f"{name} -v"
        return get_simple_cmd_output_lines(cmd)[0]
    if name == "perl":
        cmd = f"{name} -v"
        return get_simple_cmd_output_lines(cmd)[1]
    if name in ("elixir", "crystal"):
        cmd = f"{name} -v"
        text = "; ".join([line for line in get_simple_cmd_output_lines(cmd) if line])
        return text
    if name == "pypy3":
        cmd = f"{name} --version"
        return " ".join(get_simple_cmd_output_lines(cmd))
    if name == "zig":
        cmd = f"{name} version"
        return "{0} {1}".format(name, get_simple_cmd_output_lines(cmd)[0])
    if name == "node":
        cmd = f"{name} --version"
        return "Node.js {0}".format(get_simple_cmd_output_lines(cmd)[0])
    if name == "fasm":
        cmd = f"{name}"
        return get_simple_cmd_output_lines(cmd)[0]
    if name == "php":
        cmd = f"{name} --version"
        return get_simple_cmd_output_lines(cmd)[0]
    if name == "gambitc":
        cmd = f"{name} -v"
        result = get_simple_cmd_output_lines(cmd)[0].split()[0]
        return f"{name} {result}"
    if name == "stalin":
        # stalin has no -version (or similar) option...
        return "stalin 0.11"
    if name in ("numba", "numpy"):
        cmd = f'python -c "import {name}; print({name}.__version__)"'
        result = get_simple_cmd_output_lines(cmd)[0].split()[0]
        return f"{name} {result}"


def get_compiler_versions(names):
    result = []
    for name in names:
        result.append(get_version_string(name))
    #
    return result
