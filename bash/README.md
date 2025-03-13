# Text Processing Example

This is an example which makes use of some simple text processing techniques to do some very basic statistical analysis of the words contained within the works of some historical authors.

   * [job_single_data.sh](job_single_data.sh) - An example which uses processing of a larger amount of text to illustrate how some workloads cannot be easily split into parallel operations. Uses simple text processing commands (sed, tr, sort, etc) to cut and slice a text file into an ordered word frequency list.
   * [job_multi_data.sh](job_multi_data.sh) - An example which shows the use of multiple independent tasks all working on different input data simultaneously (SLURM JOB ARRAY). Uses the same text processing commands, but on multiple input data sources.

Some other files, not part of the SLURM job, but needed to support the example:

   * [make_data.sh](make_data.sh) - Downloads the required data sets (works of Shakespeare, Chaucer, Herman Melville and Homer) from the Project Gutenberg library and builds the searchable data files we use in the example.
   * [clean.sh](clean.sh) - Tidies up any downloaded data files.

## Teaching Points

   * Data sets can be any type of information.
   * Sometimes it isn't practical to split a data set into multiple parts - sometimes it only makes sense when it is all together.
   * We can still take advantage of the HPC by processing multiple independent input data at the same time (e.g. from different authors) if that data can be processed using the same commands.

## Example Performance Figures

Submit the single job as:

```
$ sbatch job_single_data.sh
```

Submit the multiple data file job as:

```
$ sbatch job_multi_data.sh
```

   * Intel Xeon E5 E5-2699 v4
      * Analysis of one data set = 22.5 seconds via  [job_single_data.sh](job_single_data.sh)
      * Analysis of four data sets simultaneously = 23 seconds via [job_multi_data.sh](job_multi_data.sh)

