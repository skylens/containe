#!/bin/bash

apt-get update -y
apt-get install -y apt-utils
apt-get install -y --no-install-recommends iproute2 curl iptables ca-certificates net-tools wireguard-tools qrencode
update-ca-certificates --fresh
apt-get clean
apt-get remove --purge