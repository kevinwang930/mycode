
# copy 
cp sample.txt sample_copy.txt
cat sample_copy.txt

# make folder
cpFolder="cpFolder"
if [ ! -d $cpFolder ]; then
    mkdir $cpFolder
fi

# copy multiple files to folder
cp sample.txt sample1.txt $cpFolder
cat sampleFolder/sample1.txt

# diff two files
diff sample.txt sample1.txt

# get format of a file
file sample.txt
