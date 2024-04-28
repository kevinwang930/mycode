# systemctl status clash-core-service.service find service start config file location
# edit config file change clash-core-service exec location to file inside install folder
sudo sed -i 's#ExecStart=.*#ExecStart=/opt/app/cfw/resources/static/files/linux/x64/service/clash-core-service#g' /usr/lib/systemd/system/clash-core-service.service

sudo systemctl daemon-reload
sudo systemctl enable clash-core-service
sudo systemctl start clash-core-service
sudo systemctl status clash-core-service.service