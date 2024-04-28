
cfw_dir=/home/kevin/myapp/cfw
curl https://gist.githubusercontent.com/Fndroid/2119fcb5ccb5a543a8f6a609418ae43f/raw/592eba4f480c7ccb4f29c9b8e80d24bfd5dda8cf/linux.sh > cfw-tun.sh

chmod +x cfw-tun.sh

sudo ./cfw-tun.sh install $cfw_dir