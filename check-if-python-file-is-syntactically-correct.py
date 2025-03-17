#!/usr/bin/env python
"""Create an abstract syntax tree of a given file and print in case of error.

Create an AST of a given file. It checks for syntactic compatibility with the
Python version it is running on.

based on:
https://stackoverflow.com/questions/40886456/how-to-detect-if-code-is-python-3-compatible

author: andreasl
"""

import ast
import sys

if len(sys.argv) != 2:
    print(f"Usage:\n{sys.argv[0]} <file>")
    sys.exit(2)


def test_source_code(code_data):
    try:
        return True, ast.parse(code_data)
    except SyntaxError as exc:
        return False, exc


print("Running on top of Python {}".format(sys.version.replace("\n", " ")))

success, result = test_source_code(open(sys.argv[1]).read())
if not success:
    print(f"Failure:\n{result}")
    sys.exit(1)
else:
    print("File looks good.")
