#!/bin/bash

COMMAND="$1"
CFW_PATH="$2"

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
SOURCE="$2/resources/static/files/linux/x64/service"
DEST="$USER_HOME/.config/clash"
INSTALLER_PATH="$CFW_PATH/resources/static/files/linux/common/service-installer"
PLIST_PATH="$INSTALLER_PATH/scripts/clash-core-service.service"
BIN_NAME="clash-core-service"

read -r -d '' PLIST_CONTENT << EOM
[Unit]
Description=Clash core service created by Clash for Windows
After=network-online.target nftables.service iptabels.service

[Service]
Type=simple
ExecStartPre=+/usr/lib/clash/setup-cgroup.sh
ExecStart=/usr/bin/bypass-proxy $DEST/service/$BIN_NAME
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOM

if [ "$COMMAND" = "install" ]; then
    cp -R $SOURCE $DEST
    echo "$PLIST_CONTENT" > "$PLIST_PATH"
    $INSTALLER_PATH/installer.sh install
    systemctl enable $BIN_NAME
    systemctl start $BIN_NAME
fi 

if [ "$COMMAND" = "uninstall" ]; then
    $INSTALLER_PATH/installer.sh uninstall
    rm -rf $PLIST_PATH
fi
