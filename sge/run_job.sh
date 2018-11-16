#!/bin/bash
#$ -cwd
#$ -o ../out/
#$ -e ../out/
#$ -M jharri1@gmu.edu
#$ -m sa

cmd=$(awk NR==$SGE_TASK_ID cmds)
eval $cmd
