#!/usr/bin/env python3

"""
This is just a small script to test if
getting version info works correctly.
"""

from lib import version


def main():
    compiler = "dotnet"
    result = version.get_version_string(compiler)
    print(result)


##############################################################################

if __name__ == "__main__":
    main()
