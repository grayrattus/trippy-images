#/bin/bash
while getopts m:o:r option
do
	case "${option}"
		in
		m) MOVIE_FILE=${OPTARG};;
		r) REMOVE_FILES=${OPTARG}
			echo "Removing old directories"
			rm -R images
			rm -R transformed_images
			;;
		o) OUTPUT_FILE=${OPTARG};;
	esac
done

if [[ -z "$MOVIE_FILE" || ! -f "$MOVIE_FILE" ]]; then
	echo "Movie file was not provided or dont't exist"
	exit -1;
fi
if [[ -z "$OUTPUT_FILE" ]]; then
	echo "Output file was not selected"
	exit -1;
fi

mkdir -p images
mkdir -p transformed_images
IMAGES="images"
TRANSFORMED_IMAGES="transformed_images"

function extract_images_from_movie() {
	ffmpeg -i $MOVIE_FILE -vf fps=24 ./$IMAGES/%d.png
}

function disperse_images() {
	echo "Dispersing images"

	bash parallel_videos.sh $IMAGES $TRANSFORMED_IMAGES 50
}

function make_video() {
	echo "Making video"
	ffmpeg -r 24 -i ${TRANSFORMED_IMAGES}/%d.png -c:v libx264 -pix_fmt yuv420p $OUTPUT_FILE
}

extract_images_from_movie
disperse_images
make_video

