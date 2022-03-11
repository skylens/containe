#!/bin/bash

apt-get update -y
apt-get install -y apt-utils
apt-get install -y --no-install-recommends git wget build-essential binutils ca-certificates file pkg-config libtool autoconf automake
update-ca-certificates --fresh

cd /opt
git clone https://github.com/WireGuard/wireguard-go
cd wireguard-go
make
make install