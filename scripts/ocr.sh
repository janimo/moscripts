#!/bin/bash

#OCR a PDF file

PDF=$1
OFILE=`basename $PDF|sed 's/.pdf//; s/ /_/g;'`
ODIR=.
if [ $# -eq 2 ] && [ -d $2 ];then
	ODIR=$2
fi

#Check whether we use the commercial trialware from ABBYY or the less accurate and slower open source Tesseract
if [ "$ABBYINSTALLDIR" != "" ];then
	echo Using ABBYY FineReader for Linux to OCR $PDF
	LD_LIBRARY_PATH=$ABBYINSTALLDIR $ABBYINSTALLDIR/abbyyocr9 -rl Romanian -if $PDF -tet UTF8 -of $ODIR/$OFILE.txt
else
	echo Using Tesseract to OCR $PDF
	DPI=600
	TIFF=$ODIR/$OFILE.tiff
	#ImageMagick's convert does more or less the same, it calls gs from what I see.
	#depending on options passed to convert or gs the output tiff's quality varies visibly but the
	#quality of the OCR results from Tesseract do not seem to be direcly correlated with increase in
	#DPI or size, it just varies with both improvements and regressions on the same text.

	#convert -density 600 $PDF $TIFF
	gs -q -dNOPAUSE -sDEVICE=tiffg3 -r$DPI  -sPAPERSIZE=a4 -sOutputFile=$TIFF $PDF -c quit
	tesseract -l ron $TIFF $ODIR/$OFILE
	rm $TIFF
fi

