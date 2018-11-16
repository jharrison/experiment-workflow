#!/bin/bash
#
# Extract from the input files specified, the lines that match the given pattern.
# The expected format of the input files is:
# name1: val1, name2: val2, ...

if [ $# -lt 2 ]; then
    echo "usage: process_output line_marker input"
fi

line_marker=$1
input=$2

grep -h $line_marker $input | head -1 | awk '{ for (i=2;i<=NF;i+=2) $i="" }1' | tr -d ' ' | sed 's/.$//' | sed 's/:/, /g'
grep -h $line_marker $input | awk '{ for (i=1;i<=NF;i+=2) $i="" }1' | tr -d ' ' | sed 's/,/, /g'
