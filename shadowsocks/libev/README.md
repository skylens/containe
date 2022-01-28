# shadowsocks-libev

编译

```bash
sudo yum install -y git wget gcc autoconf libtool automake make c-ares-devel libev-devel pcre-devel
sudo apt-get install --no-install-recommends git build-essential autoconf libtool \
libpcre3-dev libev-dev libc-ares-dev automake libmbedtls-dev libsodium-dev -y
git clone https://github.com/shadowsocks/shadowsocks-libev.git /tmp/shadowsocks-libev
cd /tmp/shadowsocks-libev
git submodule update --init --recursive
./autogen.sh && ./configure --disable-documentation && make
sudo make install
```

config.json

```bash
mkdir -p /usr/local/etc/shadowsocks-libev/
cat > /usr/local/etc/shadowsocks-libev/config.json << 'EOF'
{
    "server":"0.0.0.0",
    "server_port":8880,
    "local_port":1081,
    "password":"123456",
    "user":"nobody",
    "timeout":60,
    "method":"aes-256-gcm"
}
EOF
```

systemd

```bash
cat > /etc/systemd/system/shadowsocks-libev.service << 'EOF'
[Unit]
Description=Shadowsock-libve Service
After=network.target

[Service]
User=nobody
Type=simple
Restart=on-failure
RestartSec=5s
ExecStart=/usr/local/bin/ss-server -c /usr/local/etc/shadowsocks-libev/config.json

[Install]
WantedBy=multi-user.target

systemctl daemon-reload
```

## docker 

### Dockerfile build

```
wget https://github.com/shadowsocks/shadowsocks-libev/releases/download/v3.3.5/shadowsocks-libev-3.3.5.tar.gz

DOCKER_BUILDKIT=1 docker build -t shadowsocks-libev:0.1 .
```