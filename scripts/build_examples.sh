#! /bin/bash

for file in ../example/*.typ; do 
	echo compiling "$file"
	typst c $file --root ../
done
