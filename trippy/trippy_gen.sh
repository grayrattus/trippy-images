#/bin/bash
start=`date +%s`

runtime=$((end-start))
parallel ../disperse -s {1} -d {2} -c {3} movie290.png test_{1}_{2}_{3}.png ::: $(seq 1 15 100) ::: $(seq 1 15 100) ::: $(seq 1 15 100)

end=`date +%s`
runtime=$((end-start))

echo With parallel: $runtime >> output.txt
