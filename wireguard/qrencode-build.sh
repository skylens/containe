#!/bin/bash

export prefix=/opt/dist

ver=1.2.11
wget --no-check-certificate https://zlib.net/zlib-$ver.tar.gz
tar -xvf zlib-$ver.tar.gz
cd zlib-$ver
./configure --prefix=$prefix/zlib --static --libdir=$prefix/zlib/lib
make && make install
cd ..

wget https://sourceforge.net/projects/libpng/files/libpng16/1.6.37/libpng-1.6.37.tar.gz
tar -xvf libpng-1.6.37.tar.gz
cd libpng-1.6.37
CPPFLAGS="-I$prefix/zlib/include" \
LDFLAGS="-L$prefix/zlib/lib" \
./configure --prefix=$prefix/libpng --enable-static --disable-shared
make && make install
cd ..


git clone https://github.com/fukuchi/libqrencode
cd libqrencode
./autogen.sh
CPPFLAGS="-I$prefix/libpng/include" \
LDFLAGS="-L$prefix/libpng/lib" \
./configure --prefix=$prefix/libqrencode --enable-static --disable-shared
make && make install
cd ..