#!/bin/bash
if [ $# -ne 5 ];
then
    echo "Usage: 
        split_into_N_parts_at_pattern.sh <No. of parts> <pattern> <out_dir> <output_prefix> <input_file>
        Example:
        split_into_N_parts_at_pattern.sh 5 id outDir split input.txt"
    exit 1
fi

#create an output directory 
mkdir -p $3 && cd $3
#splitting the input into N parts using 'split'
split -e -a 5 -d --additional-suffix=.tmp -n $1 ../$5
#making sure all the split files starts with the 'pattern'
ls *.tmp|while read i
do 
csplit -n 1 -f ${i}_ ${i} "/$2/" "{0}" > /dev/null 
done
ls *.tmp|sed '$ d'|while read i
do j=$(ls *.tmp|grep -A1 "${i}"|grep -v "${i}")
k=$(ls *.tmp|grep -n '^'|grep "${i}"|cut -d ':' -f1)
cat ${i}_1 ${j}_0 > $4_${k}
done
l=$(ls *.tmp|tail -1)
m=$(ls *.tmp|grep -n '^'|tail -1|cut -d ':' -f1)
cat ${l}_1 > $4_${m}  
#removing the temporary files
rm *.tmp* 
