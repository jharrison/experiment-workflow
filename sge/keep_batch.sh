#!/bin/bash
#
# Find the next unused directory in batch{01..99} (skipping gaps),
# make that directory, then copy all the relevant files into it.

batch_num=`sh ~/common/find_next_batch_number.sh`

new_dir=$(printf "batch%02d" $batch_num)
echo "Keeping ${new_dir}"
mkdir $new_dir

# Copy stuff (run, out, runjob.sh, runall.sh) into dir
cp *.sh $new_dir
cp -r run $new_dir
mkdir $new_dir/out
cp out/*.csv* $new_dir/out
tar -zcvf $new_dir/out/output-files.tgz out/run_job*

# If comment given, echo into readme.txt
if [ ! $# -eq 0 ]; then
	echo $1 > ${new_dir}/readme.txt
fi
