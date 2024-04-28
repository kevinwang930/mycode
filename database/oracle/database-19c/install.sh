
export CV_ASSUME_DISTID=OL7
DIR=$(dirname "$BASH_SOURCE")
echo $DIR
source $DIR/install_info.sh

echo db home location $oracledb_home

cd $oracledb_home

./runInstaller # -applyRU 19.7DBRU patch 30869156 location