# HPC Workshop Job Examples

This repository contains example jobs which show how HPC can be leveraged to improve workflow throughput or decrease time waiting for results.

## c

This directory contains a simple prime number calculator.

This example shows:

   * A common algorithm shared between sequential and parallel code
   * Serial processing of an array of data
   * Chunking a data set into batches to be processed in parallel by MPI processes

Link:

   * [Prime number generation](c/README.md)

## bash

This directory contains a text processing and word frequency analysis script.

This example shows:

   * Simple serial processing of a data set which is not easily converted to parallelism.
   * Parallel analysis of multiple different data sets (SLURM JOB ARRAY)


Link:

   * [Text processing](bash/README.md)
