#! /bin/bash
# Regression tests for the template: every tests/*.typ is compiled. Header
# lines define the expectation:
#   // expect-error: <text>   compilation must fail with <text> in the error
#   // expect-text: <text>    compilation must succeed, <text> must be in the
#                             PDF (whitespace is normalized)
# Without expect-error, the file must compile without warnings, and each page
# (PNG) must match the reference image tests/ref/<name>/<page>.png; the
# difference of a failed comparison is saved in tests/diff/<name>-<page>.png.
#
# Usage: scripts/run_tests.sh            run the tests
#        scripts/run_tests.sh --update   also (re)write the reference images
#                                        of the passing tests
# ImageMagick (compare) is required for the visual comparison, curl for the
# download of the fonts (scripts/fonts.sh).
set -uo pipefail
shopt -s nullglob
cd "$(dirname "$0")/.."

# only the fonts of fonts/ (and the ones embedded in Typst), the same on every
# machine and in CI, so that the reference images match
scripts/fonts.sh || exit 1
fonts=(--ignore-system-fonts --font-path fonts)

update=false
[ "${1:-}" = "--update" ] && update=true
# resolution of the reference images, enough to see layout changes
ppi=30
# fixed date for datetime.today(), the default date of most variants, so that
# the images do not change from day to day
export SOURCE_DATE_EPOCH=1772452800 # 2026-03-02 12:00 UTC

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
rm -rf tests/diff
failed=0
passed=0

fail() {
	echo "FAIL $1: $2"
	failed=$((failed + 1))
}

# Compare the pages of the test `$1` (file) / `$2` (name) with the reference
# images, or write them with --update
visual() {
	local file=$1 name=$2 ref=tests/ref/$2 out=$tmp/png/$2
	mkdir -p "$out"
	if ! typst compile --root . "${fonts[@]}" --ppi $ppi "$file" "$out/{p}.png" > /dev/null 2>&1; then
		fail "$name" "PNG export failed"
		return 1
	fi
	if $update; then
		rm -rf "$ref"
		mkdir -p "$ref"
		cp "$out"/*.png "$ref"/
		return 0
	fi
	if [ ! -d "$ref" ]; then
		fail "$name" "no reference images, create them with scripts/run_tests.sh --update"
		return 1
	fi
	local pages ref_pages
	pages=$(cd "$out" && ls | sort)
	ref_pages=$(cd "$ref" && ls | sort)
	if [ "$pages" != "$ref_pages" ]; then
		fail "$name" "$(wc -w <<< "$pages") pages instead of $(wc -w <<< "$ref_pages")"
		return 1
	fi
	local page diff
	for page in $pages; do
		# number of differing pixels; a different image size is an error
		diff=$(compare -metric AE "$ref/$page" "$out/$page" "$tmp/diff.png" 2>&1)
		diff=${diff%% *}
		if [ "$diff" != 0 ]; then
			mkdir -p tests/diff
			cp "$tmp/diff.png" "tests/diff/$name-$page" 2> /dev/null
			fail "$name" "page ${page%.png} differs from the reference ($diff pixels), see tests/diff/$name-$page"
			return 1
		fi
	done
}

for file in tests/*.typ; do
	name=$(basename "$file" .typ)
	errors=$(sed -n 's|^// expect-error: ||p' "$file")
	texts=$(sed -n 's|^// expect-text: ||p' "$file")
	output=$(typst compile --root . "${fonts[@]}" "$file" "$tmp/$name.pdf" 2>&1)
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
	$ok || continue
	visual "$file" "$name" && passed=$((passed + 1))
done

if $update; then
	# remove the reference images of deleted tests and of error tests
	for dir in tests/ref/*/; do
		name=$(basename "$dir")
		if [ ! -f "tests/$name.typ" ] || grep -q "^// expect-error: " "tests/$name.typ"; then
			rm -rf "$dir"
		fi
	done
fi

echo "$passed passed, $failed failed"
[ $failed -eq 0 ]
