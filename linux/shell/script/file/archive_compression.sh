tar cvf archive.tar sample.txt sample1.txt
gzip -f archive.tar 
if [[ ! -d "archive" ]]; then
    mkdir archive
fi
gunzip archive.tar.gz 
echo check the contents of all files in archive.tar
tar tf archive.tar
tar xvf archive.tar --directory archive
cat archive/sample.txt
