cd /opt/
major_version=10
minor_version=1.4
version=${major_version}.${minor_version}
package_name=apache-tomcat-${version}.tar.gz
folder_name=apache-tomcat-${version}
target_folder_name=tomcat${major_version}
wget -c https://downloads.apache.org/tomcat/tomcat-${major_version}/v${version}/bin/${package_name}
tar -xvf ${package_name} 
mv ${folder_name} ${target_folder_name}
chmod +x ${target_folder_name}/bin/*.sh




