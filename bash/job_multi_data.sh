#!/bin/bash

#SBATCH --partition=short
#SBATCH --job-name=data_sort_multi
#SBATCH --nodes=1
#SBATCH --tasks=4
#SBATCH --array=1-4
#SBATCH --cpus-per-task=1

# Do a word frequency analysis of each of the following
# data sets simultaneously:
#
# data.1 - The collected works of Shakespeare
# data.2 - Geoffrey Chaucers Cantebury Tales 
# data.3 - Moby Dick by Herman Melville
# data.4 - Homers Odyssey
#
# We should be able to process all four data sets in the same
# time it took to process just the first.

echo "Starting word frequency analysis of data.${SLURM_ARRAY_TASK_ID}"
echo "================================"

time cat data.${SLURM_ARRAY_TASK_ID} | \
	sed s'/\ /\n/g' | \
	tr -c -d "[A-Za-z\n]" | \
	tr [A-Z] [a-z] | \
	sort | \
	strings -n 1 | \
	uniq -c | \
	sort -n > data.${SLURM_ARRAY_TASK_ID}.out

echo "================================"
echo "Completed word analysis of data.${SLURM_ARRAY_TASK_ID}"
