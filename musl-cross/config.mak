TARGET = x86_64-linux-musl
OUTPUT = /opt/x86_64-linux-musl-cross 
GCC_VER = 9.2.0
COMMON_CONFIG += CFLAGS="-g0 -Os" CXXFLAGS="-g0 -Os" LDFLAGS="-s"