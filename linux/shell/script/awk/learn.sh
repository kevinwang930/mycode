awk '{print $0}' marks.txt
awk '{print $1}' marks.txt
awk -f command.awk marks.txt

# print lines match certain pattern

awk '/a/ {print}' marks.txt

awk '/a/{++cnt} END {print "Count=",cnt}' marks.txt 

awk 'length($0)>180 {print}' marks.txt

awk 'BEGIN {print "Arguments= ",ARGC}' One Two Three Four

awk 'BEGIN { 
   for (i = 0; i <= ARGC - 1; ++i) { 
      printf "ARGV[%d] = %s\n", i, ARGV[i] 
   } 
}' one two three four


awk 'END {print FILENAME}' marks.txt

echo -e "One Two\nOne Two Three\nOne Two Three Four" | awk 'NF > 2'

awk 'NR==3' marks.txt

