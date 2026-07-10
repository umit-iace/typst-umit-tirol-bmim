#! /bin/bash
shopt -s extglob

for file in ../example/!(*preamble).typ; do
	echo compiling "$file"
	typst c $file --root ../
done
