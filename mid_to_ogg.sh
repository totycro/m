#!/bin/sh

TIMIDITY_ARGS="--volume=100"  
#TIMIDITY_ARGS=""
j=0
#dropbox stop

D="/tmp/foooobarr"
mkdir "$D" 2>/dev/null
OUT="${D}/fiiifooo_not_rlly"
# can't pass data out of find | while read subshell, so stupidly use files
DAT="${D}/dat"
rm -f $OUT
rm -f $DAT

touch $DAT
touch $OUT

# wait for every 3rd job, so that not all too many run at the same time
find . -iname "*$@*.mid" | cut -d'/' -f 2 | while read i ; do
	echo $i
	if [ $((j%3)) -eq 2 ] ; then
 		# run one now really
		nice timidity $TIMIDITY_ARGS -Aa -Ov "$i" 
	else
		# reg job, call out when finished
		echo "job" >> "$DAT"
		(nice timidity $TIMIDITY_ARGS -Aa -Ov "$i"; echo "done" >> "$OUT" )  &
	fi
	let j+=1
done


while [ "x$(cat "$DAT" | wc -l)" != "x$(cat "$OUT" | wc -l)" ]; do
	echo "waiting for tasks.."
	sleep 2
done

#dropbox start

# STUPID HACK:
# name files back, default output converts . to _
echo "rename.."
find . -iname "*.ogg" | while read i ; do
	mv "$i" "`echo $i | tr _ .`" 2>/dev/null 
done

