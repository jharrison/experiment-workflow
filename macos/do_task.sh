#!/bin/bash

# set the number of nodes
#SBATCH --nodes=1

# set name of job
#SBATCH --job-name=test123

# mail alert at start, end and abortion of execution
##SBATCH --mail-type=END,FAIL

# send mail to this address
##SBATCH --mail-user=joey.f.harrison@gmail.com

#SBATCH -o ../out/task.%a.out # STDOUT
#SBATCH -e ../out/task.%a.err # STDERR

#SBATCH --mem=500


# Extract the nth line from the cmds file and run it
cmd=$(awk NR==$SLURM_ARRAY_TASK_ID cmds)
eval $cmd
