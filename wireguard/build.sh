#!/bin/bash

# https://www.fanyueciyuan.info/fq/ss-libev-3_3_4.html
# https://gist.github.com/harv/dd0bcd5eba533cbc267f6a0aaf6bee62

apt-get update -y
apt-get install -y apt-utils
apt-get install -y --no-install-recommends git wget build-essential binutils ca-certificates file pkg-config libtool autoconf automake python3-pip
apt-get install -y --no-install-recommends wireguard-tools
# pip install <package> --download=<download-directory> --no-binary=:all:
# pip install qrcode --download=./ --no-binary=:all:
# pip install qrcode
update-ca-certificates --fresh

export CC=/opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-gcc AS=/opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-as LD=/opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-ld CXX=/opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-g++ AR=/opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-ar RANLIB=/opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-ranlib
export prefix=/opt/dist
export host=x86_64-linux-musl
export PATH=/opt/x86_64-linux-musl-cross/bin:$PATH

# cd /opt
# git clone https://github.com/WireGuard/wireguard-tools
# cd wireguard-tools/src
# make
# make install