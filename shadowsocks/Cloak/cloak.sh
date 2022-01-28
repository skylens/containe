#!/bin/bash

apt install -y --no-install-recommends git upx

git clone https://github.com/cbeuw/Cloak.git /tmp/Cloak
cd /tmp/Cloak
# 取出最新的版本号
git tag | tail -1
go get ./...
# go build -ldflags "-X main.version=$(git tag | tail -1)" ./cmd/ck-server
# env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags " -s -w" -o ./ck-server ./cmd/ck-server
env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags " -s -w -X main.version=$(git tag | tail -1)" -o ./ck-server ./cmd/ck-server
# upx 压缩
upx /tmp/Cloak/ck-server

cp /tmp/Cloak/ck-server /usr/local/bin/

mkdir -p /usr/local/etc/cloak/
cat > /usr/local/etc/cloak/ck-server.json << 'EOF'
{
    "ProxyBook":{
    "shadowsocks":["tcp","127.0.0.1:8880"]
    },
    "BindAddr":[":8443"],
    "BypassUID":[],
    "RedirAddr":"www.bing.com",
    "PrivateKey":"kPI6r8n7IiRTMhlXRzrGP0+TwmOJLdutLpETFjD7I3A=",
    "AdminUID":"RdKsWXAZX0hT1Ou+PWVWkA==",
    "DatabasePath":"/usr/local/etc/cloak/userinfo.db"
}
EOF

# 修改 json 配置文件值（python 修改）


cat > /etc/systemd/system/cloak.service << 'EOF'
[Unit]
Description=Cloak Server Service
After=network.target

[Service]
Type=simple
User=nobody
Restart=on-failure
RestartSec=5s
ExecStart=/user/local/bin/ck-server -c /usr/local/etc/cloak/ck-server.json

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload

systemctl start cloak
systemctl enable cloak