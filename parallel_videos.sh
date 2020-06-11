#!/bin/bash

IMAGES=$1
TRANSFORMED_IMAGES=$2
files_in_grups=$3

files=""
num_of_files_for_batch_parallel=0;

s_parameter=($(seq 1 6 50))
s_parameter_index=1
for file_name in $(ls $IMAGES | sort -n); do
	if (( $num_of_files_for_batch_parallel >= $files_in_grups )); then 
		echo $files
		parallel --null --bar ./disperse -s ${s_parameter[$s_parameter_index]} -d 1 -c 16 ./${IMAGES}/{1} ./${TRANSFORMED_IMAGES}/{1} ::: $files 
		((s_parameter_index+=1))
		num_of_files_for_batch_parallel=0
		files=""
		if (( "${#s_parameter[@]}" < $s_parameter_index )); then
			s_parameter_index=0
		fi
	fi

	((num_of_files_for_batch_parallel+=1))
	files+=" $(basename $file_name)"
done 

echo $files | parallel --null --bar ./disperse -s ${s_parameter[$s_parameter_index]} -d 1 -c 16 ./${IMAGES}/{/} ./${TRANSFORMED_IMAGES}/{/}
