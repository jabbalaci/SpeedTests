import shlex
from subprocess import PIPE, STDOUT, Popen


def get_simple_cmd_output(cmd, stderr=STDOUT) -> str:
    args = shlex.split(cmd)
    return Popen(args, stdout=PIPE, stderr=stderr).communicate()[0].decode("utf8")


def get_simple_cmd_output_lines(cmd, stderr=STDOUT) -> list[str]:
    return get_simple_cmd_output(cmd, stderr).splitlines()
