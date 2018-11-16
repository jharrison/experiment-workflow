#!/bin/bash
#
# Find the next unused directory in batch{01..99} (skipping gaps)

# this script will only work up to batch 99, so check for that first
if [ -d "batch99" ]; then
	echo "Error: this script only works up to batch99 and batch99 already exists."
	exit
fi

# loop backwards so we don't stop at any gaps (e.g. if batch03 has been deleted)
next_num=1 # default in case there are no batch directories
for n in `seq 99 -1 1`; do
	filename=$(printf "batch%02d" $n)
	#echo "looking for ${filename}..."
	if [ -d $filename ]; then
		#echo "found it"
		next_num=$(($n + 1))
		break
	fi
done

printf "%02d" $next_num
