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
unzip corbel.zip

cd $PROJECT_ROOT

echo "Building $FINAL"
mkdir -p _build/parts 2>/dev/null
for SVG_FILE in $(ls *.svg);
	do
		PDF_FILE=$(echo $SVG_FILE | sed 's/\.svg$/\.pdf/')
		convert $SVG_FILE _build/parts/$PDF_FILE;
done
convert $(ls _build/parts/*.pdf) _build/$FINAL
