#!/bin/bash

PREFIX='/opt/dist'
git clone https://github.com/shadowsocks/v2ray-plugin $PREFIX/v2ray-plugin
cd $PREFIX/v2ray-plugin

env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --tags) -s -w -buildid=$(date +%FT%T%z)" -gcflags "" -o $PREFIX/release/v2ray-plugin/linux/v2ray-plugin

env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --tags) -s -w -buildid=$(date +%FT%T%z)" -gcflags "" -o $PREFIX/release/v2ray-plugin/darwin/v2ray-plugin

env CGO_ENABLED=0 GOOS=freebsd GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --tags) -s -w -buildid=$(date +%FT%T%z)" -gcflags "" -o $PREFIX/release/v2ray-plugin/freebsd/v2ray-plugin

env CGO_ENABLED=0 GOOS=windows GOARCH=amd64 \
go build -v -ldflags "-X main.VERSION=$(git describe --tags) -s -w -buildid=$(date +%FT%T%z)" -gcflags "" -o $PREFIX/release/v2ray-plugin/windows/v2ray-plugin.exe