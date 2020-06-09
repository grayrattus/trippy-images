#/bin/bash
# Update images with caption of spread,density,curvines
# taken from picture name

while getopts d: option
do
	case "${option}"
		in
		d) DIRECTORY=${OPTARG};;
	esac
done

for file_path in $(ls $DIRECTORY/*.png); do
	file_name=$(basename -s'.png' $file_path)
	echo $file_name
	spread=$(cut -d'_' -f 2 <<< $file_name)
	density=$(cut -d'_' -f 3 <<< $file_name)
	curvines=$(cut -d'_' -f 4 <<< $file_name)
	echo $spread $density $curvines
	 montage -label "s: $spread d: $density c: $curvines" $file_path\
	 	-pointsize 90 \
		-frame 5  -geometry +0+0 $(basename $file_path)
done
