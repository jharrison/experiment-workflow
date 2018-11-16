#!/bin/bash
#
# Calculate the difference in timestamp between the cmds file and the newest
# file in the out directory.

# this does it in seconds (borrowed from stack exchange)
# echo $((`stat --format=%Y .bashrc` - `stat --format=%Y .bashrc~`))

convert_secs() {
   ((h=${1}/3600))
   ((m=(${1}%3600)/60))
   ((s=${1}%60))
   printf "%02d:%02d:%02d\n" $h $m $s
}

newest_file=$(ls -t out/* | head -1)
other_file="run/cmds"

duration=$((`stat --format=%Y ${newest_file}` - `stat --format=%Y ${other_file}`))

convert_secs ${duration}
