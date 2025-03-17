#!/usr/env/bin python3
"""Scan a given Python file and check if long functions have docstrings.

Usage:
  python check-if-long-functions-have-docstrings.py 50 myfile.py

author: andreasl
"""

import ast
import sys


def parse_python_file(filename: str):
    """Return the ast from a given python file."""
    with open(filename) as file:
        root = ast.parse(file.read())
    return root


def get_last_deep_child(ast_node):
    """Get the last sub-element, deepest sub-node from the given AST node."""
    if not hasattr(ast_node, "body"):
        return ast_node
    return get_last_deep_child(ast_node.body[-1])


def find_all_function_nodes(ast_root):
    """Retrieve all function, also nested, nodes from the given AST node."""
    if not hasattr(ast_root, "body"):
        return []

    fun_nodes = []
    for node in ast_root.body:
        if isinstance(node, ast.FunctionDef):
            fun_nodes.append(node)
        fun_nodes.extend(find_all_function_nodes(node))
    return fun_nodes


def get_node_loc(node):
    """Get the lines of code that the node and its sub-nodes use."""
    lineno = node.lineno
    end_lineno = get_last_deep_child(node).lineno
    return end_lineno - lineno


def run(max_loc, filename):
    """Run the linter."""
    root = parse_python_file(filename)
    nodes = find_all_function_nodes(root)
    for node in nodes:
        loc = get_node_loc(node)
        if loc > max_loc and not ast.get_docstring(node):
            print(
                f"{filename}:{node.lineno}:{node.col_offset} L001 function "
                f"with {loc} LoC lacks docstring"
            )


if __name__ == "__main__":
    run(
        max_loc=int(sys.argv[1]),
        filename=sys.argv[2],
    )
