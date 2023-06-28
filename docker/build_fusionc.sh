tar jxf ${FUSIONC_ARCHIVE}
CWD=`pwd`
cd fusion-c/source/lib
./_build_lib.sh
cd $CWD
cp -r fusion-c /usr/local

