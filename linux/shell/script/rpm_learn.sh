# install

rpm -ivh rpm_package_name

# erase uninstall
# --nodeps do not check dependencies
rpm -e rpm_package_name

# query all installed packages

rpm -qa


# upgrade package_file

rpm {-U | --upgrade} [install-options] package_file


