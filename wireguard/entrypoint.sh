#!/bin/bash

finish () {
    wg-quick down wg0
    exit 0
}
trap finish SIGTERM SIGINT SIGQUIT

sysctl -w net.ipv4.conf.all.src_valid_mark=1
sysctl -w net.ipv4.ip_forward=1
sysctl -p
sysctl --system

wg-quick up /etc/wireguard/wg0.conf

# Inifinite sleep
sleep infinity &
wait $!