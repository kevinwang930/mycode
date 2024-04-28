cfw_version=0.20.31
install_location=/opt/app

file_name=Clash.for.Windows-${cfw_version}-x64-linux
package_name=Clash.for.Windows-${cfw_version}-x64-linux.tar.gz
tar_name=Clash.for.Windows-${cfw_version}-x64-linux.tar
decompressed_name="Clash for Windows-${cfw_version}-x64-linux"

stopProcess() {
    systemctl stop clash-core-service
    tmp=$(ps -ef | grep cfw | grep -v grep | awk '{print $2}')
    echo ${tmp}
    for id in $tmp; do
        kill -9 $id
        echo "killed $id"
    done
}

download() {
    if test ! -f $package_name && test ! -f $tar_name; then
        echo start downloading ...
        wget https://github.com/Fndroid/clash_for_windows_pkg/releases/download/${cfw_version}/Clash.for.Windows-${cfw_version}-x64-linux.tar.gz
    else
        echo $file_name exists skip download
    fi
}

unzip() {
    if [ -d "$decompressed_name" ]; then 
        echo 'targeted dir already exists, skip unzip'
    else 
        gunzip -k $package_name
        tar xf $file_name.tar --directory .
    fi
}

install() {
    if [ -d "$decompressed_name" ]; then
        echo 'start install'
        stopProcess
        echo processes stoped
        rm -rf cfw
        echo old files deleted
        mv "$decompressed_name" cfw
        echo new files added
        ./cfw/cfw &
        exit 0
    else 
        echo 'can not find target folder during install'
        exit 1
    fi
}

cd $install_location
echo cd $install_location
download
unzip
install



