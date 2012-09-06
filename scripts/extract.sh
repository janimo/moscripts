#!/bin/sh
#
#Extracts Romanian text from PDF
#

ODIR=.
if [ $# -eq 2 ] && [ -d $2 ];then
	ODIR=$2
fi

PDF=$1
TXT=`basename $PDF|sed 's/pdf/txt/; s/ /_/g;'`
TMP=$TXT.tmp
#If text output already present exit
[ -f $ODIR/$TXT ] && exit 0

#The string FontName is found in PDF files that have extractable text
grep FontName "$PDF" >/dev/null
if [ $? -eq 1 ];then
	./scripts/ocr.sh $PDF $ODIR
	exit
fi
echo Extracting text from $PDF

pdftotext -enc UTF-8 "$PDF" $TMP
#
#cat $TMP | perl -pe 's/˛/ț/g; s/∫/ș/g; s/„/ă/g; s/‚/â/g; s/î/\xe2\x80\x9d/g; s/Ó/î/g; s/¬/Â/g; s/ﬁ/Ț/g; s/™/Ș/g; s/√/Ă/g; s/Œ/Î/g' >$TXT

#Put these in a table for readability?
cat $TMP | perl -pe 's/˛/ț/g; s/∫/ș/g; s/„/ă/g; s/‚/â/g; s/Ò/,,/g; s/Ó/î/g; s/¬/Â/g; s/ﬁ/Ț/g; s/™/Ș/g; s/√/Ă/g; s/Œ/Î/g; s/ª/Ș/g; s/º/ș/g; s/þ/ț/g;s/Þ/Ț/g; s/Ġ/ț/g;' >$ODIR/$TXT
rm $TMP
