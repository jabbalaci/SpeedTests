from lib.process import get_simple_cmd_output_lines


def get_version_string(name):
    if name in ("gcc", "g++", "clang", "clang++", "dmd", "gdc",
                "mypyc", "nim", "rustc", "python3", "python3.11", "dart", "ghc", "julia",
                "nasm", "racket", "gfortran", "ruby", "clisp", "sbcl", "chez", "guile"):
        cmd = f"{name} --version"
        result = get_simple_cmd_output_lines(cmd)[0].strip()
        if name == "chez":
            result = f"{name} {result}"
        #
        return result
    if name == "ldc2":
        cmd = f"{name} --version"
        return get_simple_cmd_output_lines(cmd)[0].replace(":", "")
    if name in ("java", "kotlin", "v"):
        cmd = f"{name} -version"
        return get_simple_cmd_output_lines(cmd)[0]
    if name == "dotnet":
        cmd = f"{name} -h"
        return get_simple_cmd_output_lines(cmd)[0]
    if name in ("go", "odin"):
        cmd = f"{name} version"
        return get_simple_cmd_output_lines(cmd)[0]
    if name in ("lua", "luajit", "fpc"):
        cmd = f"{name} -v"
        return get_simple_cmd_output_lines(cmd)[0]
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
    if name == "gambitc":
        cmd = f"{name} -v"
        result = get_simple_cmd_output_lines(cmd)[0].split()[0]
        return f"{name} {result}"
    if name == "stalin":
        # stalin has no -version (or similar) option...
        return "stalin 0.11"


def get_compiler_versions(names):
    result = []
    for name in names:
        result.append(get_version_string(name))
    #
    return result
