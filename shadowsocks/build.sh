#!/bin/bash

apt-get update -y
apt-get install -y --no-install-recommends git wget build-essential binutils ca-certificates
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
make -j16 && make install
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
make -j16 && make install
cd ..

ver=1.17.1
wget --no-check-certificate https://c-ares.haxx.se/download/c-ares-$ver.tar.gz
tar zxf c-ares-$ver.tar.gz
cd c-ares-$ver
./configure --prefix=$prefix/libc-ares --host=$host --disable-shared
make -j16 && make install
cd ..

# ver=3.3.5
# wget --no-check-certificate https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$ver/sshadowsocks-libev-$ver.tar.gz
# tar zxf shadowsocks-libev-$ver.tar.gz
# cd shadowsocks-libev-$ver
wget --no-check-certificate https://github.com/shadowsocks/shadowsocks-libev/releases/download/v3.3.5/shadowsocks-libev-3.3.5.tar.gz
tar -xvf shadowsocks-libev-3.3.5.tar.gz
cd shadowsocks-libev-3.3.5
LDFLAGS="-Wl,-static -s -static-libgcc -L$prefix/libev/lib" \
CFLAGS="-g0 -Os -I$prefix/libev/include" \
CXXFLAGS="-g0 -Os" ./configure --prefix=$prefix/shadowsocks-libev \
--disable-ssp --disable-documentation --with-sodium=$prefix/libsodium \
--with-mbedtls=$prefix/mbedtls --with-pcre=$prefix/pcre \
--with-cares=$prefix/libc-ares --host=$host
make -j16 && make install