dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
dnf upgrade
subscription-manager repos --enable "rhel-*-optional-rpms" --enable "rhel-*-extras-rpms"
yum install snapd