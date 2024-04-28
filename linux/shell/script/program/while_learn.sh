s=0
while [ $s -le 100 ]
do 	
	s=$[$s+1]
done 
echo value of s $s


NUM=0
while((NUM<=10));do let NUM++; done
echo $NUM


while ((s>=10)) ; do let s--;done
echo $s
