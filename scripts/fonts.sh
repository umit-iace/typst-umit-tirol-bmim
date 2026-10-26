#! /bin/bash
# Download the fonts of the template in fixed versions into fonts/ (or the
# given directory): Source Serif 4, Source Sans 3, Source Code Pro, Bitstream
# Vera Sans (letter) and Nimbus Sans (text next to the LFUI logo). The tests
# render with these fonts only, so that the reference images are the same on
# every machine and in CI. Nothing is downloaded if the fonts are up to date.
#
# Usage: scripts/fonts.sh [directory]
set -euo pipefail
cd "$(dirname "$0")/.."

dest=${1:-fonts}
# version of this set of fonts, increase it when changing the downloads below
version=1
if [ "$(cat "$dest/.version" 2> /dev/null)" = "$version" ]; then
	exit 0
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

# download <url> <sha256> <file name>, checked against the checksum
get() {
	curl -sSfL -o "$tmp/$3" "$1"
	local sum
	if command -v sha256sum > /dev/null; then
		sum=$(sha256sum "$tmp/$3")
	else
		sum=$(shasum -a 256 "$tmp/$3")
	fi
	if [ "${sum%% *}" != "$2" ]; then
		echo "checksum of $1 does not match" >&2
		exit 1
	fi
}

echo "downloading fonts (version $version) into $dest/"
get "https://github.com/adobe-fonts/source-serif/releases/download/4.005R/source-serif-4.005_Desktop.zip" \
	549fdb8f9a682bd06944298621404969f6de77c2e422ff3b8244a1dcd6a0c425 serif.zip
get "https://github.com/adobe-fonts/source-sans/releases/download/3.052R/OTF-source-sans-3.052R.zip" \
	a4ebbdea20b08ccbd7bf3665a9462454eefdd01d9a6307129d3b3d4672981074 sans.zip
get "https://github.com/adobe-fonts/source-code-pro/releases/download/2.042R-u%2F1.062R-i%2F1.026R-vf/OTF-source-code-pro-2.042R-u_1.062R-i.zip" \
	754a2e3ebb945ae905d720ac5896b3b34acc9546dd6551ef9536869788629dae mono.zip
get "https://download.gnome.org/sources/ttf-bitstream-vera/1.10/ttf-bitstream-vera-1.10.tar.bz2" \
	db5b27df7bbb318036ebdb75acd3e98f1bd6eb6608fb70a67d478cd243d178dc vera.tar.bz2
get "https://github.com/ArtifexSoftware/urw-base35-fonts/archive/refs/tags/20200910.tar.gz" \
	e0d9b7f11885fdfdc4987f06b2aa0565ad2a4af52b22e5ebf79e1a98abd0ae2f urw.tar.gz

mkdir -p "$tmp/x"
for zip in serif sans mono; do
	unzip -q "$tmp/$zip.zip" -d "$tmp/x/$zip"
done
tar -xjf "$tmp/vera.tar.bz2" -C "$tmp/x"
tar -xzf "$tmp/urw.tar.gz" -C "$tmp/x"

# static fonts only (no variable fonts), as installed in CI before
mkdir -p "$dest"
find "$dest" -maxdepth 1 -type f \( -name '*.otf' -o -name '*.ttf' -o -name .version \) -delete
find "$tmp/x" \( -path '*/OTF/*.otf' -o -name 'Vera*.ttf' -o -path '*/fonts/NimbusSans-*.otf' \) \
	-exec cp {} "$dest/" \;
echo "$version" > "$dest/.version"
echo "$(find "$dest" -maxdepth 1 -type f \( -name '*.otf' -o -name '*.ttf' \) | wc -l) fonts in $dest/"
