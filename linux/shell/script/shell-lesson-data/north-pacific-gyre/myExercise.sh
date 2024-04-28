for datafile in NENE*A.txt NENE*B.txt
do 
    bash goostats.sh $datafile stats-$datafile
done