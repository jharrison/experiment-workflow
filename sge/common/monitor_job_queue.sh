#!/bin/bash
#
# Check to see if the job queue is empty

# If there's a number given, it indicates the expected number of output files created.
# First, loop until the expected number of output files have been created
if [ $# -gt 0 ]; then
	expected_nof=$1 # expected number of output files
	prev_nof=-1
	while [ : ]; do
		nof=`find out -maxdepth 1 -name "run_job.sh.o*" | wc -l`

		if [ $nof -ne $prev_nof ]; then
			percentage=`bc -l <<< "scale=2; (${nof}*100) / ${expected_nof}"`
			echo "Output files created = ${nof} (${percentage}%)"
			prev_nof=$nof
		fi

		if [ $nof -eq $expected_nof ]; then
			echo 'All output files created.'
			break
		fi

		sleep .2
	done
fi

# Second, loop until the job queue is empty
echo "Checking job queue..."
prev_num_jobs=-1
while [ : ]; do
	num_jobs=`qstat -U jharri1 | grep jharri1 | wc -l`

	if [ $num_jobs -ne $prev_num_jobs ]; then
		echo "num_jobs = ${num_jobs}"
		prev_num_jobs=$num_jobs
	fi

	if [ $num_jobs -eq 0 ]; then
		echo 'Job queue empty.'
		mail -s "ARGO job completed" joeyfharrison@gmail.com <<< "The queue is empty, at least."
		break
	fi

	sleep .2
done
