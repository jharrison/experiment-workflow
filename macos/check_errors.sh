#!/bin/bash
#
# Count the non-empty .err files, and the empty .out files.

err_file_count=$(ls *.err | wc -l)
nonempty_err_file_count=$(find *.err -type f ! -empty | wc -l)
echo "${nonempty_err_file_count} / ${err_file_count} .err files are non-empty."
find *.err -type f ! -empty -ls


out_file_count=$(ls *.out | wc -l)
empty_out_file_count=$(find *.out -type f -empty | wc -l)
echo "${empty_out_file_count} / ${out_file_count} .out files are empty."
find *.out -type f -empty -ls
