#!/bin/bash

if [ -z "$1" ]; then
	echo "Did not specify the name of output file"
	exit 1
fi

FINAL=$1
PROJECT_ROOT=$(pwd)

echo "Installing fonts"
mkdir ~/.fonts 2> /dev/null
cd ~/.fonts
wget https://www.wfonts.com/download/data/2014/11/28/corbel/corbel.zip
unzip -o corbel.zip
wget https://www.wfonts.com/download/data/2014/05/29/impact/impact.zip
unzip -o impact.zip

cd $PROJECT_ROOT

echo "Building $FINAL"
mkdir -p _build/parts 2>/dev/null
for SVG_FILE in $(ls *.svg);
	do
		PDF_FILE=$(echo $SVG_FILE | sed 's/\.svg$/\.pdf/')
		inkscape $SVG_FILE --export-pdf=_build/parts/$PDF_FILE
done
pdftk $(ls _build/parts/*.pdf) cat output _build/$FINAL
