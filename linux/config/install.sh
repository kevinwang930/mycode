SOURCE_DIR='/home/kevin/Downloads'
DIST_DIR='/code/BI'

SOURCE_NAME='pdi-ce-9.2.0.0-290'

if [ ! -d $DIST_DIR ]; then
    mkdir -p $DIST_DIR
fi

unzip ${SOURCE_DIR}/${SOURCE_NAME}.zip -d $DIST_DIR
