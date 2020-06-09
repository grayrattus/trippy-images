#/bin/bash
# rm psycho/*
# rm images/*
# ffmpeg -i psycho_movie.mp4 -vf fps=24 images/movie%d.png
# echo "Making crazy shit"
# for ima in images/*; do ./disperse -s 5 -d 5 -c 5 $ima psycho/$(basename $ima); done

declare -a regular_expressions=("movie[0-9].png" "movie[1-5][0-9].png" "movie[6-9][0-9].png" "movie1[0-5][0-9].png" "movie1[6-9][0-9].png" "movie2[0-5][0-9].png" "movie2[6-9][0-9].png" "movie3[0-5][0-9].png" "movie3[6-9][0-9].png" "movie4[0-5][0-9].png" "movie4[6-9][0-9].png" "movie5[0-5][0-9].png" "movie5[6-9][0-9].png"
                )

let regular_expression_index=0;
for i in $(seq 1 2 20); do
	find images -name "${regular_expressions[$regular_expression_index]}" -print0 | parallel --null --bar ./disperse -s 5 -d 5 -c 5 images/{/} psycho/psycho_{/}
	((regular_expression_index++))
done;

# echo "Making video"
# ffmpeg -r 24 -i psycho/movie%d.png -c:v libx264 -pix_fmt yuv420p out.mp4

