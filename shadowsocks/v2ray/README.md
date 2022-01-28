# v2ray-plugin


## 编译

```bash
git clone https://github.com/shadowsocks/v2ray-plugin.git
cd v2ray-plugin
VERSION=$(git describe --tags)
LDFLAGS="-X main.VERSION=$VERSION -s -w -buildid="
env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -ldflags "$LDFLAGS" -o v2ray-plugin-linux
env CGO_ENABLED=0 GOOS=freebsd GOARCH=amd64 go build -v -ldflags "$LDFLAGS" -o v2ray-plugin-freebsd
env CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -v -ldflags "$LDFLAGS" -o v2ray-plugin-darwin
```

## 配置 websocket + TLS + Nginx + Cloudfare

### shadowsocks-libev

```
{
    "server":"127.0.0.1",
    "server_port":65533,
    "password":"WSRKsf3G0VZM2n%NxMb9D",
    "timeout":300,
    "method":"aes-256-gcm",
    "plugin":"v2ray-plugin",
    "plugin_opts":"server;tls;host=t2.readdemo.com;cert=/opt/ssl/fullchain.pem;key=/opt/ssl/privkey.pem;path=/wss147cd3fa68f61aa78e207eff5a8895c6;loglevel=none"
}
```

### nginx

```
server {
    listen 443 ssl http2;
    server_name xxxx;
    
    ssl_certificate /opt/ssl/fullchain.pem;
    ssl_certificate_key /opt/ssl/privkey.pem;
    ssl_protocols TLSv1.3;
    ssl_early_data on;
    
    # root /usr/local/www/nginx-dist;
    root /usr/share/nginx/html;
	
    location / {
        index index.html;
    }
    
    location /wss {
        proxy_redirect off;
        proxy_pass https://127.0.0.1:65533;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}


```

客户端

```
{
    "server":"xxx.m.com",
    "server_port":443,
    "local_port":1086,
    "password":"xxxxxxx",
    "timeout":60,
    "method":"aes-256-gcm",
    "nameserver":"8.8.8.8",
    "plugin": "v2ray-plugin",
    "plugin_opts": "tls;host=xxx.m.com;path=/wss;loglevel=none"
}

```