echo ~ | cd 
echo $(pwd)
cd /home && ls
cd -
echo $(pwd)
echo `pwd`
cat animal.csv | head -n 5 | tail -n 3 | sort -r 