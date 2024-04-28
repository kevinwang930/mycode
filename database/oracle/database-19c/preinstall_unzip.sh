DIR=$(dirname "$BASH_SOURCE")
echo $DIR
source $DIR/install_info.sh
mkdir -p $oracledb_home
cd $oracledb_home
unzip -q /u01/LINUX.X64_193000_db_home.zip
