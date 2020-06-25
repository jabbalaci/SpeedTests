#!/usr/bin/env python3

import json
import os
import sys
from glob import glob
from pathlib import Path

from lib import benchmark, makefile, table, version
from lib.fs import ChDir

THIS_FILE = Path(sys.argv[0]).name
HERE = Path(os.path.dirname(os.path.abspath(__file__)))
ROOT = HERE.parent
BENCHMARK_OUTPUT_DIR = Path(HERE, "output")

RE_TEST = True
# RE_TEST = False


def get_folder_list():
    dnames = sorted([e for e in os.listdir(ROOT) if os.path.isdir(Path(ROOT, e))])
    dnames = [e for e in dnames if not e.startswith((".", "_"))]
    folder = Path(ROOT, "_parallel")
    if os.path.isdir(folder):
        for e in os.listdir(folder):
            if os.path.isdir(Path(folder, e)):
                dnames.append(f"_parallel/{e}")
    #
    return dnames


ACCEPTED_FOLDERS = get_folder_list()


def print_usage():
    print(f"""
Usage: {THIS_FILE} <folder>

Where <folder> can be one of the following:
""".strip())
    for e in ACCEPTED_FOLDERS:
        print(f"* {e}")


def read_json(dname):
    fname = f"{dname}.json"
    with open(fname) as f:
        return json.load(f)


def call_make(key, lang_dir, out_file):
    with ChDir(lang_dir):
        os.system("make clean")
        cmd = f"make {key}"
        print("#", cmd)
        os.system(cmd)
        #
        if out_file != "--":
            assert(os.path.isfile(out_file))


def process(lang_dir, config):
    compilers = config["compilers"]
    versions = version.get_compiler_versions(compilers)
    mf = makefile.read_makefile(lang_dir)
    md_table = table.Table()
    md_table.build_headers_part(config)
    if "special" not in config:
        for key, value in mf.items():
            if key.startswith("v"):
                out_file = config["output_file"]
                call_make(key, lang_dir, out_file)
                file_size = os.path.getsize(Path(lang_dir, out_file))
                if RE_TEST:
                    benchmark.run_test(lang_dir, BENCHMARK_OUTPUT_DIR, key)
                runtime = benchmark.get_result(BENCHMARK_OUTPUT_DIR, key)
                md_table.add_row(value, runtime, file_size)
                # break
            #
        #
    else:
        for d in config["special"]:
            # special's output_file overrides the "global" output_file in the JSON
            out_file = config["output_file"]
            if "output_file" in d:
                out_file = d["output_file"]
            #
            compile_key = d["compile"]
            if compile_key != "--":
                compile_cmd = mf[compile_key]
            run_key = d["run"]
            run_cmd = mf[run_key]
            out_name = compile_key if compile_key != "--" else run_key
            if compile_key != "--":
                call_make(compile_key, lang_dir, out_file)
                file_size = os.path.getsize(Path(lang_dir, out_file))
            if RE_TEST:
                benchmark.run_test(lang_dir, BENCHMARK_OUTPUT_DIR, out_name, cmd=run_cmd)
            runtime = benchmark.get_result(BENCHMARK_OUTPUT_DIR, out_name)
            if compile_key != "--":
                first_column_value = f"{compile_cmd} && {run_cmd}"
            else:
                first_column_value = run_cmd
            if compile_key == "--":
                file_size = "--"
            md_table.add_row(first_column_value, runtime, file_size)
    #
    md_table.sort()

    print("-" * 20)
    print(f"### {config['section_name']}")
    print()
    for ver in versions:
        print(f"* {ver}")
    print()
    print(md_table)
    print("-" * 20)


def clean_benchmark_output_dir():
    dname = BENCHMARK_OUTPUT_DIR
    files = glob(f"{dname}/*.md") + glob(f"{dname}/*.json")
    for f in files:
        os.remove(f)
        assert(not os.path.isfile(f))


def start(dname):
    if dname not in ACCEPTED_FOLDERS:
        print("Error: unknown folder")
        exit(1)
    # else:
    if RE_TEST:
        clean_benchmark_output_dir()
    workdir = Path(ROOT, dname)
    config = read_json(dname)
    process(workdir, config)

##############################################################################

if __name__ == "__main__":
    if len(sys.argv) == 1:
        print_usage()
        exit(0)
    # else:
    dname = sys.argv[1]
    start(dname)
