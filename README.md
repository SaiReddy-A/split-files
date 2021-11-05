# split-files
### Splitting a large file into multiple files of specified number at a pattern string

Handling of large data files such as mummer delta files or fasta files is difficult sometimes, and it'd be easier to split these files into chunks of N parts and run analyses.

The [split_nucmer_delta.sh](split_nucmer_delta.sh) script splits the delta file from mummer utils into user specified N parts. Each individual split delta file will have a header to make it readable by other mummer utilities. 

The [split_any_file.sh](split_any_file.sh) script will split any file into N parts at a user specified pattern string. It works well with the fasta files too.


### Installation<br />
    https://github.com/SaiReddy-A/split-files.git

 
### Usage:<br />
   `split_nucmer_delta.sh <No. of parts> <out_dir> <output_prefix> <input_file>`
     
   `split_any_file.sh <No. of parts> <pattern> <out_dir> <output_prefix> <input_file>`
    
Output is stored in <out_dir>/<output_prefix>_1 .... <out_dir>/<output_prefix>_N
    
    
### Examples:
   `split_nucmer_delta.sh 5 out_split split input.delta`
   
   `split_any_file.sh 10 '>' out_fasplit split input.fasta`
   
   `split_any_file.sh 20 foo dir_out out input.txt`
