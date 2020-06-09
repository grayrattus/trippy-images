#/bin/bash
start=`date +%s`

runtime=$((end-start))
parallel ../disperse -s {1} -d {2} -c {3} movie290.png test_{1}_{2}_{3}.png ::: $(seq 1 15 100) ::: $(seq 1 15 100) ::: $(seq 1 15 100)

# for s in $(seq 1 5 100); do
# 	for d in $(seq 1 5 100); do
# 		for c in $(seq 1 5 100); do
# 			echo values: $s $d $c;
# 			../disperse -s $s -d $d -c $c movie290.png test_$s\_$d\_$c.png
# 		done
# 	done
# done


end=`date +%s`
runtime=$((end-start))

echo With parallel: $runtime >> output.txt
