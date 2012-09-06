#!/bin/bash

#converts all pdf files to text
ODIR=.
if [ $# -ge 1 ] && [ -d $1 ];then
	ODIR=$1
fi
PERIOD=*
#Fixme to cover periods not just a single year.
if [ $# -eq 2 ];then
	PERIOD=$2
fi
for d in data/www.moficial.ro/$PERIOD ;do
	o=$ODIR/`basename $d`
	mkdir -p $o
	for pdf in $d/*pdf;do
		./scripts/extract.sh $pdf $o
	done
done
