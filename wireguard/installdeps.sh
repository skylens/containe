#!/bin/bash

apt-get update -y
apt-get install -y apt-utils
apt-get install -y --no-install-recommends iptables
update-ca-certificates --fresh