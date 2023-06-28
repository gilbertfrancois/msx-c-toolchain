tar jxf ${SDCC_ARCHIVE}
cd sdcc-${SDCC_VERSION}
./configure --prefix=/usr/local \
  --disable-pic14-port    \
  --disable-pic16-port    \
  --disable-mcs51-port    \
  --disable-r2k-port      \
  --disable-r3ka-port     \
  --disable-tlcs90-port   \
  --disable-ds390-port    \
  --disable-ds400-port    \
  --disable-hc08-port     \
  --disable-s08-port      \
  --disable-stm8-port     \
  --disable-pdk13-port    \
  --disable-pdk14-port    \
  --disable-pdk15-port    
make -j$(nproc)
make install
cd ..
