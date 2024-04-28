#!/bin/bash

version=8.1.1

PATH='$PATH'

download_file=gradle-$version-bin.zip
if [ ! -f /tmp/$download_file ]; then
    echo "Downloading file to /tmp/gradle-$version-bin.zip"
    /usr/bin/wget -O "/tmp/gradle-$version-bin.zip" https://services.gradle.org/distributions/gradle-$version-bin.zip
else 
    echo $download_file already exists
fi
echo "export PATH=\"${PATH}:/opt/gradle/bin\"" >> $HOME/.bashrc
source $HOME/.bashrc

echo "Creating Gradle's home folder at /opt/gradle"
/usr/bin/sudo mkdir /opt/gradle
/usr/bin/sudo /usr/bin/unzip -d /opt/ /tmp/gradle-$version-bin.zip

echo "Gradle Install Complete!"
echo "Please run gradle --version to confirm install!"