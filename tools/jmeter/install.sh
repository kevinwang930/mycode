version=5.5
install_location=/opt/app

file_name=apache-jmeter-${version}.tgz
tar_name=apache-jmeter-${version}.tar
install_folder=apache-jmeter-${version}


download() {
    if test ! -f $file_name; then
        echo start downloading ...
        wget https://dlcdn.apache.org//jmeter/binaries/apache-jmeter-${version}.tgz
    else
        echo $file_name exists skip download
        exit -1
    fi
}

unzip() {
    if [ -d "$install_folder" ]; then 
        echo 'targeted dir already exists, skip unzip'
    else 
        tar zxvf $file_name
    fi
}

cd $install_location
echo cd $install_location

download
unzip
sudo ln -sf ${install_folder}/bin/jmeter /usr/local/bin/jmeter



