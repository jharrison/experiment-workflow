#!/bin/bash

export path=/home/jharri1/lonc
if [ ! -d ${path}/out ]; then
	mkdir ${path}/out
fi

rm -f ${path}/out/*

sh sweep_params.sh > run/cmds

num_jobs=`wc -l < run/cmds`
echo "num_jobs: $num_jobs"

cd ${path}/run
qsub -t 1-${num_jobs} ${path}/run_job.sh

cd ${path}
sh ~/common/monitor_job_queue.sh ${num_jobs}


# Check to see if there were any errors
if [ `cat out/run_job.sh.e* | wc -c` != 0 ]; then
	msg=$(printf "Errors occured:\n%s\n...\n" "`cat out/run_job.sh.e* | head`")
	echo -e "$msg"
	echo -e "$msg" | mail -s "ARGO job encountered errors" joeyfharrison@gmail.com
	exit 1
fi


batch_num=`sh ~/common/find_next_batch_number.sh`
out_file=$(printf "out/batch%02d-event-gen-sweep.csv.gz" $batch_num)

sh ~/common/process_output.sh "popSize:" "out/run_job.sh.o*" | gzip > $out_file

# Keep the batch. Include the comment if one was given
comment=$([ $# -eq 0 ] && echo "" || echo $1)
sh keep_batch.sh "$comment"
