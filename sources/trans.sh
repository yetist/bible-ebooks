#!/bin/bash

CURDIR=`realpath .`

process() {
	for i in `find -name "*.html" -o -name "*.htm" -o -name "*.css"`;
	do
		dos2unix $i
		new=${i%.*}
		iconv -f gb18030 -t utf8 $i > ${new}.new
		sed -i 's///g' ${new}.new
		html2text ${new}.new > ${new}.txt
		markdown ${new}.txt > $i
		sed -i '0,/<p>/{s/p/h1/g}' $i
		rm -f ${new}.new ${new}.txt
	done
}

download() {
	local url=$1 outdir=$2
	TMP=`mktemp -d`
	cd $TMP
	wget -r -np $url
	cd $outdir
	process
	bname=`basename $outdir`
	mkdir $CURDIR/$bname
	cp -r * $CURDIR/$bname
	rm -rf $TMP
	echo "$bname is ready."
}

if [ $# -ge 1 ];then
	url=$1
	htmldir=`dirname $url`
	out=${htmldir#http://*}
	download $url $out
fi

