#!/bin/bash

# set the number of nodes
## SBATCH --nodes=1

# set name of job
#SBATCH --job-name=test123

# mail alert at start, end and abortion of execution
#SBATCH --mail-type=END

# send mail to this address
#SBATCH --mail-user=joey.f.harrison@gmail.com

#SBATCH -o ../out/slurm.%j.%a.out # STDOUT
#SBATCH -e ../out/slurm.%j.%a.err # STDERR

#SBATCH --ntasks=1
## SBATCH --array=1-4

# run the application
cmd=$(awk NR==$SLURM_ARRAY_TASK_ID cmds)
eval $cmd
