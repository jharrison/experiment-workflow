#!/bin/bash

email="joeyfharrison@gmail.com"
#email=""
out_path=out

if [ ! -d ${out_path} ]; then
	mkdir ${out_path}
fi

rm -f ${out_path}/*
rm run/*.log

sh sweep_params.sh > run/cmds

num_jobs=$(wc -l < run/cmds)
echo "num_jobs: $num_jobs"


params="--workdir=run"
if [ ! -z ${email} ]; then	params="${params} --mail-user=${email} --mail-type=END,FAIL"; fi

# qsub -t 1-${num_jobs} ${path}/run_job.sh # SGE
sbatch -a 1-${num_jobs} ${params} do_task.sh

sh ~/common/monitor_job_queue.sh ${num_jobs} "${out_path}/*.out"

if [ ! -z ${email} ]; then	mail -s "ARGO job completed" ${email} <<< "The queue is empty, at least."; fi

# Check to see if there were any errors
if [ $(cat ${out_path}/*.err | wc -c) != 0 ]; then
	msg=$(printf "Errors occured:\n%s\n...\n" "$(cat ${out_path}/*.err | head)")
	echo -e "$msg"
	if [ ! -z ${email} ]; then echo -e "$msg" | mail -s "ARGO job encountered errors" ${email}; fi
	# exit 1
fi


batch_num=$(sh ~/common/find_next_batch_number.sh record)
results_file=$(printf "${out_path}/batch%02d-results.csv.gz" $batch_num)

sh ~/common/process_output.sh "popSize:" "${out_path}/*.out" | gzip > $results_file

# Keep the batch. Include the comment if one was given
comment=$([ $# -eq 0 ] && echo "" || echo $1)
sh keep_batch.sh record "$comment"
