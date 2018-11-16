#!/bin/bash

cmd=$(awk NR==$1 $2)

echo $cmd
