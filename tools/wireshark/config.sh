# set live cap privilege in user mode
sudo setcap cap_net_raw,cap_net_admin+eip /usr/bin/dumpcap
# add current user to wireshark group
sudo gpasswd -a $USER wireshark