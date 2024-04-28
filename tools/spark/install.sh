
install_location=/opt/user
package_name=spark-3.5.0-bin-hadoop3-scala2.13.tgz


download() {
    if test ! -f $package_name; then
        echo start downloading ...
        wget https://dlcdn.apache.org/spark/spark-3.5.0/spark-3.5.0-bin-hadoop3-scala2.13.tgz
    else
        echo $package_name exists skip download
    fi
}

unzip() {
    tar -xzf $package_name 
}



cd $install_location
echo cd $install_location
download
if [ $? -ne 0 ]; then
            echo "Download failed"
            exit 1
fi
unzip




