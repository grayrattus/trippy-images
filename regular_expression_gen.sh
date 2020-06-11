#!/bin/bash

directory_name=$1
files_in_grups=$2

files=""
num_of_files_for_batch_parallel=0;
for file_name in $directory_name/*; do
	if [[ num_of_files_for_batch_parallel -gt files_in_grups ]]; then 
		echo $files
		echo $files | parallel --null --bar ./disperse -s $i -d 1 -c 16 ./${IMAGES}/{/} ./${TRANSFORMED_IMAGES}/psycho_{/}
		num_of_files_for_batch_parallel=0
		files=""
	fi
	files+=" $(basename $file_name)"
	echo $files
done 

