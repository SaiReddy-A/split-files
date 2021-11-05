#!/bin/bash
if [ $# -ne 4 ];
then
    echo "Usage: 
        split_nucmer_delta.sh <No. of parts> <out_dir> <output_prefix> <input_file>
        Example:
        split_nucmer_delta.sh 5 outDir split nucmer.delta"
    exit 1
fi

#create an output directory 
mkdir -p $2 && cd $2
#saves the delta header file to 'header'
head -2 ../$4 > header
#splitting the input into N parts using 'split'
split -e -a 5 -d --additional-suffix=.tmp -n $1 ../$4
#making sure all the split files starts with '>' without losing any lines 
ls *.tmp|while read i
do 
csplit -n 1 -f ${i}_ ${i} '/>/' "{0}" > /dev/null 
done
ls *.tmp|sed '$ d'|while read i
do j=$(ls *.tmp|grep -A1 "${i}"|grep -v "${i}")
k=$(ls *.tmp|grep -n '^'|grep "${i}"|cut -d ':' -f1)
cat header ${i}_1 ${j}_0 > $3_${k}.delta
done
l=$(ls *.tmp|tail -1)
m=$(ls *.tmp|grep -n '^'|tail -1|cut -d ':' -f1)
cat header ${l}_1 > $3_${m}.delta  
#removing the temporary files
rm *.tmp* header
