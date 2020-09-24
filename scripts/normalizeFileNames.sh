for folder in log out
do
	for num in `seq 1 9`
	do
		mv ${folder}/timetest${num}_snaq.${folder} ${folder}/timetest0${num}_snaq.${folder}
	done
done