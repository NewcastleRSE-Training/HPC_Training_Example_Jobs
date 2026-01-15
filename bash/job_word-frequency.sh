#!/bin/bash

#SBATCH --partition=short
#SBATCH --job-name=data_sort_single
#SBATCH --nodes=1
#SBATCH --tasks=1
#SBATCH --cpus-per-task=1

echo "Starting word frequency script"
bash word-freq.sh [input file here]
echo "Finished word frequency script"
