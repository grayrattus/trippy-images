#/bin/bash
start=`date +%s`

runtime=$((end-start))
for s in $(seq 1 5 100); do
	for d in $(seq 1 5 100); do
		for c in $(seq 1 5 100); do
			../disperse -s $s -d $d -c $c movie290.png test_$s_$d_$c.png
		done
	done
done


end=`date +%s`
runtime=$((end-start))

echo Without parallel: $runtime >> output.txt
