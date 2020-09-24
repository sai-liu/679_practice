touch ../output/analysis.csv
touch ../output/hmax.csv
touch ../output/CPUtime.csv
touch ../output/Summary.csv
echo analysis > ../output/analysis.csv
echo h > ../output/hmax.csv
echo CPUtime > ../output/CPUtime.csv
cd ../log
for name in *.*
do
    grep -o "rootname for files: .*" $name | cut -f4 -d" " >> ../output/analysis.csv
	grep -o "hmax = [0-9]*" $name | cut -f3 -d" " >> ../output/hmax.csv
	temp=$(echo $name  | cut -f1 -d".")
	grep -o "Elapsed time: [0-9]*\.[0-9]*" ../out/$temp.out | cut -f3 -d" " >> ../output/CPUtime.csv
done

paste -d , ../output/analysis.csv ../output/hmax.csv ../output/CPUtime.csv > ../output/Summary.csv

rm ../output/analysis.csv ../output/hmax.csv ../output/CPUtime.csv

