import json
import os
from pathlib import Path

from lib.fs import ChDir

HYPERFINE = "hyperfine"
MIN_RUNS = 3    # Perform at least NUM runs for each command (default: 10).
WARMUP_NUM = 2    # Perform NUM warmup runs before the actual benchmark.


def run_test(lang_dir, output_dir, key, cmd="./main"):
    md_file = Path(output_dir, f"{key}.md")
    json_file = Path(output_dir, f"{key}.json")
    with ChDir(lang_dir):
        cmd = f"{HYPERFINE} -m {MIN_RUNS} --warmup {WARMUP_NUM} '{cmd}' --export-markdown '{md_file}' --export-json '{json_file}'"
        print("#", cmd)
        os.system(cmd)


def get_result(output_dir, key):
    json_file = Path(output_dir, f"{key}.json")
    with open(json_file) as f:
        d = json.load(f)
    #
    d = d["results"][0]
    mean = round(d["mean"], 3)
    stddev = round(d["stddev"], 3)
    return (mean, stddev)


def get_formatted_result(output_dir, key):
    mean, stddev = get_result(output_dir, key)
    return f"{mean} ± {stddev}"
