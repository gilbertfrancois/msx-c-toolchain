#==[ Build image ]=============================================================
FROM ubuntu:22.04 as build

ENV SDCC_VERSION=4.0.0
ENV HEX2BIN_VERSION=2.5

ENV SDCC_ARCHIVE=sdcc-src-${SDCC_VERSION}.tar.bz2
ENV HEX2BIN_ARCHIVE=Hex2bin-${HEX2BIN_VERSION}-patched.tar.bz2
ENV FUSIONC_ARCHIVE=fusion-c.tar.bz2

RUN apt update && apt install -y \
    build-essential \
    git \   
    pkg-config \
    bzip2 \
    make \
    flex \
    bison \
    byacc \
    python3-dev \
    texinfo \
    libboost-graph-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /builddir

# Build sdcc compiler
COPY build_sdcc.sh /builddir
COPY 3rdparty/${SDCC_ARCHIVE} /builddir
RUN /builddir/build_sdcc.sh
# Make sdcc compatible with Fusion-C
RUN cd /usr/local/share/sdcc/lib/z80 && \
    cp z80.lib z80.lib.orig && \
    sdar -d z80.lib prinf.rel && \
    sdar -d z80.lib sprintf.rel && \
    sdar -d z80.lib vprinf.rel && \
    sdar -d z80.lib putchar.rel && \
    sdar -d z80.lib getchar.rel

# Install hex2bin tool
COPY build_hex2bin.sh /builddir
COPY 3rdparty/${HEX2BIN_ARCHIVE} /builddir
RUN /builddir/build_hex2bin.sh

# Install Fusion-C
COPY build_fusionc.sh /builddir
COPY 3rdparty/${FUSIONC_ARCHIVE} /builddir
RUN /builddir/build_fusionc.sh

#==[ Development image ]=======================================================

FROM ubuntu:22.04

ENV PATH=/usr/local/bin:$PATH

RUN apt update && apt install -y \
    make \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /usr/local /usr/local

SHELL ["/bin/bash", "-c"]

WORKDIR /workdir
