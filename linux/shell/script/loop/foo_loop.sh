for filename in basilisk.dat minotaur.dat unicorn.dat
do
    head -n 2 $filename | tail -n 1
done


for num in $(seq 0 9)
do 
    echo -n "$num " 
done
echo

for datafile in *.dat
do 
    ls -l $datafile
done

for datafile in b*
do 
    ls -l $datafile
done

# for datafile in *.dat
# do 
#     cat $datafile >> all.dat
# done

for datafile in b*
do 
    echo $datafile
    head -n 10 "$datafile" | tail -n 1
done
