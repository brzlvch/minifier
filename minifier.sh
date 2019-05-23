#!/usr/local/bin/bash

# Version log
version="tmp/.version"

# Temporary version log
vrsn="tmp/.vrsn"

# Assets path
assets="assets"

# YUI Compressor path
compressor="yuicompressor-x.y.z.jar"

if [ ! -f $version ]; then
	echo -n > $version;
fi;

# File copy function (from => to)
Copying() {
	echo "Copied $1 => $2 …"
	cp $1 $2; #
};

# Recording changes in the temporary log (file => MD5 hash)
Versioning() {
	echo "$1 => $2" >> $vrsn;
};

# Looking for all files
for file in $(find $assets -type f); do

	md5hash=$(echo `md5 < ${file}`);
	nfile=$(echo $file | sed "s/-src//g");

	Versioning $file $md5hash;

	if grep -q $md5hash $version && [ -f $nfile ] ; then
		continue;
	else
		mkdir -p $(dirname "$nfile");

		if [ "${file##*.}" = "js" ]; then
			if java -jar $compressor --type js $file -o $nfile --charset utf-8 --nomunge 2>/dev/null; then
				echo "Compressed $file …"
			else 
				Copying $file $nfile;
			fi;
		elif [ "${file##*.}" = "css" ]; then
			if java -jar $compressor --type css $file -o $nfile --charset utf-8 2>/dev/null; then
				echo "Compressed $file …"
			else
				Copying $file $nfile;
			fi;
		else
			Copying $file $nfile;
		fi;
	fi;
done;

cat $vrsn > $version;
rm $vrsn;

echo -e "\nMinify is complete!"