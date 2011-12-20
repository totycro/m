#!/bin/sh
TIMIDITY_ARGS="--volume=140" 
if test $# -gt 0; then
	echo $@
	find . -iname "*$@*.mid" | cut -d'/' -f 2 | while read i ; do
	echo $i
		timidity $TIMIDITY_ARGS -Aa -Ov "$i" 
	done
else
	ls *.mid | while read i ; do
		timidity $TIMIDITY_ARGS -Aa -Ov "$i" 
	done
fi

# STUPID HACK:
# name files back, default output converts . to _
find . -iname "*.ogg" | while read i ; do
	mv "$i" "`echo $i | tr _ .`"
done

