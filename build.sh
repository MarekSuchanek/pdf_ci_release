#!/bin/bash

FINAL=$1

mkdir -p _build/pages 2>/dev/null
for SVG_FILE in $(ls *.svg);
	do convert $SVG_FILE _build/parts/$SVG_FILE.pdf;
done
convert $(ls _build/parts/*.pdf) $FINAL
