#!/bin/bash
#
# Find the next unused directory in batch{01..99} (skipping gaps),
# make that directory, then copy all the relevant files into it.
#
# Usage: keep_batch.sh path comment

path="."
if [ $# -gt 0 ]; then
	path=$1
fi

batch_num=$(sh ~/common/find_next_batch_number.sh ${path})

dest=$(printf "${path}/batch%02d" $batch_num)
echo "Keeping ${dest}"
mkdir -p $dest

# Copy stuff (run, out, scripts) into dir
cp *.sh $dest
cp -r run $dest
mkdir $dest/out
cp out/*.csv* $dest/out
tar -zcf $dest/out/output-files.tgz out/task*


# If comment given, echo into readme.txt
if [ $# -gt 1 ]; then
	echo $2 > ${dest}/readme.txt
fi
