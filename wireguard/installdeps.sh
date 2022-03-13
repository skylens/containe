#!/bin/bash

apt-get update -y
apt-get install -y apt-utils
apt-get install -y --no-install-recommends iptables ca-certificates net-tools wireguard-tools qrencode
update-ca-certificates --fresh