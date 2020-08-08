# Make an .icns file from a .png file (for creating macOS app icons)
# Usage: ./makeicns <filename> <imagesize>
# Example: ./makeicns Edit.png 256

if [ $# -ne 2 ] ; then
	printf "Use this format: ./makeicns <file name>.png <image size>\neg. ./makeicns Edit.png 256\n"
	exit
fi

filename="${1%.*}"
extension="${1##*.}"
echo "$extension"
iconset="$filename.iconset"
mkdir "$iconset"
cp "$1" "$iconset/icon_$2x$2.$extension"
iconutil --convert icns "$iconset"
rm -rf "$iconset"