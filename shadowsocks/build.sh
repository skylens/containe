#!/bin/bash

# https://www.fanyueciyuan.info/fq/ss-libev-3_3_4.html
# https://gist.github.com/harv/dd0bcd5eba533cbc267f6a0aaf6bee62

apt-get update -y
apt-get install -y apt-utils
apt-get install -y --no-install-recommends git wget build-essential binutils ca-certificates file ibtool autoconf automake
update-ca-certificates --fresh

export CC=/opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-gcc AS=/opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-as LD=/opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-ld CXX=/opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-g++ AR=/opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-ar RANLIB=/opt/x86_64-linux-musl-cross/bin/x86_64-linux-musl-ranlib
export prefix=/opt/dist
export host=x86_64-linux-musl
export PATH=/opt/x86_64-linux-musl-cross/bin:$PATH

ver=1.2.11
wget --no-check-certificate https://zlib.net/zlib-$ver.tar.gz
tar -xvf zlib-$ver.tar.gz
cd zlib-$ver
./configure --prefix=$PREFIX/zlib --static --libdir=$PREFIX/zlib/lib
make && make install
cd ..

ver=8.45
wget --no-check-certificate https://sourceforge.net/projects/pcre/files/pcre/$ver/pcre-$ver.tar.gz
# wget --no-check-certificate https://ftp.pcre.org/pub/pcre/pcre-$ver.tar.gz
tar zxf pcre-$ver.tar.gz
cd pcre-$ver
CPPFLAGS="-DNEED_PRINTF" ./configure --prefix=$prefix/pcre --host=$host --enable-jit --enable-utf8 --enable-unicode-properties --disable-shared
make && make install
cd ..

ver=2.16.6
wget --no-check-certificate --no-check-certificate https://tls.mbed.org/download/mbedtls-$ver-gpl.tgz
tar zxf mbedtls-$ver-gpl.tgz
cd mbedtls-$ver
make DESTDIR=$prefix/mbedtls install
# make lib && make install
cd ..

ver=1.0.18
wget --no-check-certificate --no-check-certificate https://download.libsodium.org/libsodium/releases/libsodium-$ver.tar.gz
tar zxf libsodium-$ver.tar.gz
cd libsodium-$ver
./configure --prefix=$prefix/libsodium --host=$host --disable-ssp --disable-shared
make && make install
cd ..

ver=4.33
wget --no-check-certificate http://dist.schmorp.de/libev/libev-$ver.tar.gz
tar zxf libev-$ver.tar.gz
cd libev-$ver
./configure --prefix=$prefix/libev --host=$host --disable-shared
make && make install
cd ..

ver=1.17.1
wget --no-check-certificate https://c-ares.haxx.se/download/c-ares-$ver.tar.gz
tar zxf c-ares-$ver.tar.gz
cd c-ares-$ver
./configure --prefix=$prefix/libc-ares --host=$host --disable-shared
make && make install
cd ..

git clone https://github.com/shadowsocks/shadowsocks-libev
cd shadowsocks-libev
git submodule update --init --recursive
./autogen.sh
LIBS="-lpthread -lm" LDFLAGS="-Wl,-static -static-libgcc -L$prefix/libc-ares/lib -L$prefix/libev/lib" \
CFLAGS="-I$prefix/libc-ares/include -I$prefix/libev/include" \
./configure --prefix=$prefix/shadowsocks-libev \
--disable-ssp --disable-documentation --with-sodium=$prefix/libsodium \
--with-mbedtls=$prefix/mbedtls --with-pcre=$prefix/pcre \
--with-cares=$prefix/libc-ares --host=$host
make && make install

git clone https://github.com/shadowsocks/simple-obfs
cd simple-obfs
git submodule update --init --recursive
./autogen.sh
LIBS="-lpthread -lm" LDFLAGS="-Wl,-static -static-libgcc -L$prefix/libc-ares/lib -L$prefix/libev/lib -L$prefix/libsodium/lib" \
CFLAGS="-I$prefix/libc-ares/include -I$prefix/libev/include -I$prefix/libsodium/include" \
./configure --prefix=$prefix/shadowsocks-libev --host=$host --disable-ssp --disable-documentation
make && make install