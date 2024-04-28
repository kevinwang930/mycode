dnf -y install https://download.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
yum-config-manager --enable powertools
dnf localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm
dnf install --nogpgcheck https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm

dnf install ffmpeg
dnf -y install ffmpeg-devel