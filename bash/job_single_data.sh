#!/bin/bash

#SBATCH --partition=short
#SBATCH --job-name=data_sort_single
#SBATCH --nodes=1
#SBATCH --tasks=1
#SBATCH --cpus-per-task=1

# Do a word frequency analysis of the collected works of Shakespeare

DATA_FILE=data.1

echo "Starting word frequency analysis of $DATA_FILE"
echo "=============================================="

time cat $DATA_FILE | \
	sed s'/\ /\n/g' | \
	tr -c -d "[A-Za-z\n]" | \
	tr [A-Z] [a-z] | \
	sort | \
	strings -n 1 | \
	uniq -c | \
	sort -n > data.out

echo "====================================="
echo "Completed word analysis of $DATA_FILE"
