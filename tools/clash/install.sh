clash_version=1.
download_dir='/home/kevin/Downloads'
package_name=clash-linux-amd64-v${clash_version}.gz
file_name=clash-linux-amd64-v${clash_version}


cd $download_dir
if [ ! -f $package_name ]; then
    wget https://github.com/Dreamacro/clash/releases/download/v${clash_version}/${package_name}
else
    echo $package_name already exists
fi

gunzip -k $package_name
sudo mv $file_name /usr/local/bin/clash
sudo chmod +x /usr/local/bin/clash
./clash

sudo mv ~/.config/clash /etc
