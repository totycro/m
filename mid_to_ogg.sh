#!/bin/sh

TIMIDITY_ARGS="--volume=120" 
#TIMIDITY_ARGS=""
j=0
/home/totycro/bin/dropbox.py stop
find . -iname "*$@*.mid" | cut -d'/' -f 2 | while read i ; do
	echo $i
	if [ $((j%3)) -eq 2 ] ; then
		echo 1
 		# run one now really
		timidity $TIMIDITY_ARGS -Aa -Ov "$i" 
	else
		echo 2
		timidity $TIMIDITY_ARGS -Aa -Ov "$i"  &
		LAST_PID=$!
	fi
	let j+=1
done

wait $LAST_PID


/home/totycro/bin/dropbox.py start

# STUPID HACK:
# name files back, default output converts . to _
echo "rename.."
find . -iname "*.ogg" | while read i ; do
	mv "$i" "`echo $i | tr _ .`" 2>/dev/null
done

