#! /bin/bash
# Regression tests for the template: every tests/*.typ is compiled. Header
# lines define the expectation:
#   // expect-error: <text>   compilation must fail with <text> in the error
#   // expect-text: <text>    compilation must succeed, <text> must be in the
#                             PDF (whitespace is normalized)
# Without expect-error, the file must compile without warnings.
#
# Usage: scripts/run_tests.sh
set -uo pipefail
shopt -s nullglob
cd "$(dirname "$0")/.."

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
failed=0
passed=0

fail() {
	echo "FAIL $1: $2"
	failed=$((failed + 1))
}

for file in tests/*.typ; do
	name=$(basename "$file" .typ)
	errors=$(sed -n 's|^// expect-error: ||p' "$file")
	texts=$(sed -n 's|^// expect-text: ||p' "$file")
	output=$(typst compile --root . "$file" "$tmp/$name.pdf" 2>&1)
	status=$?

	if [ -n "$errors" ]; then
		if [ $status -eq 0 ]; then
			fail "$name" "compiled, but an error was expected"
			continue
		fi
		ok=true
		while IFS= read -r expected; do
			if ! grep -qF -- "$expected" <<< "$output"; then
				fail "$name" "error does not contain '$expected':"
				echo "$output" | head -3 | sed 's/^/    /'
				ok=false
				break
			fi
		done <<< "$errors"
		$ok && passed=$((passed + 1))
		continue
	fi

	if [ $status -ne 0 ]; then
		fail "$name" "compilation failed:"
		echo "$output" | head -5 | sed 's/^/    /'
		continue
	fi
	if grep -q "^warning:" <<< "$output"; then
		fail "$name" "compilation produced warnings:"
		echo "$output" | head -3 | sed 's/^/    /'
		continue
	fi
	ok=true
	if [ -n "$texts" ]; then
		content=$(pdftotext "$tmp/$name.pdf" - | tr -s '[:space:]' ' ')
		while IFS= read -r expected; do
			if ! grep -qF -- "$expected" <<< "$content"; then
				fail "$name" "PDF does not contain '$expected'"
				ok=false
				break
			fi
		done <<< "$texts"
	fi
	$ok && passed=$((passed + 1))
done

echo "$passed passed, $failed failed"
[ $failed -eq 0 ]
