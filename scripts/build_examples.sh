#! /bin/bash
set -euo pipefail
shopt -s extglob

for file in ../example/!(*preamble).typ; do
	echo compiling "$file"
	typst c "$file" --root ../
done

echo compiling ../template/main.typ
typst c ../template/main.typ ../example/template.pdf --root ../
