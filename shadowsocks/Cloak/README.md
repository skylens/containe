# Cloak

编译

```
git clone https://github.com/cbeuw/Cloak.git /tmp/Cloak
cd /tmp/Cloak
# 取出最新的版本号
git tag | tail -1
go get ./...
env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags "-X main.version=$(git tag | tail -1) -s -w" -o ./ck-server ./cmd/ck-server
env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags "-X main.version=$(git tag | tail -1) -s -w" -o ./ck-client ./cmd/ck-client
# upx 压缩
upx /tmp/Cloak/ck-server
```

安装

```
cp ck-server /usr/local/bin/
```

配置文件

```
mkdir /usr/local/etc/cloak/
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
    "DatabasePath":"userinfo.db"
}
EOF
```

systemd

```bash
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
```

客户端配置

```
{
    "server":"1.1.1.1",
    "server_port":8443,
    "local_port":1080,
    "password":"password",
    "timeout":60,
    "method":"aes-256-gcm",
    "plugin": "ck-client",
    "plugin_opts": "Transport=direct;ProxyMethod=shadowsocks;EncryptionMethod=plain;UID=RdKsWXAZX0hT1Ou+PWVWkA==;PublicKey=ry3VEVfxSqqSZzEitbJ/EO+uzH3ML+sj4nnQA+keNFM=;ServerName=www.bing.com;NumConn=4;BrowserSig=chrome;StreamTimeout=300"
}
```