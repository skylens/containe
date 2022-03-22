# headscale

### 二进制

```bash

```

### docker

```bash
docker pull ghcr.io/juanfont/headscale:latest

docker run --name headscale -p 8080:8080/tcp ghcr.io/juanfont/headscale:latest 
```

## tailscale

### 二进制

```bash
wget https://ftp.skylens.co/tailscale_1.22.2_amd64.tgz
tar zxvf tailscale_1.22.2_amd64.tgz
cd tailscale_1.22.2_amd64
cp tailscaled /usr/sbin/tailscaled
cp tailscale /usr/bin/tailscale
cp systemd/tailscaled.defaults /etc/default/tailscaled
cp systemd/tailscaled.service /lib/systemd/system/tailscaled.service

systemctl enable --now tailscaled
systemctl status tailscaled
```

### 注册到 headscale 控制节点

```bash
tailscale up --login-server=http://<HEADSCALE_PUB_IP>:8080 --accept-routes=true --accept-dns=false
```

## 内网访问

```bash
echo 'net.ipv4.ip_forward = 1' | tee /etc/sysctl.conf
echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.conf
sysctl -p /etc/sysctl.conf


tailscale up --login-server=http://<HEADSCALE_PUB_IP>:8080 --accept-routes=true --accept-dns=false --advertise-routes=172.16.32.0/24

# 需要访问内网的机器
headscale routes enable -i 2 -r "172.16.32.0/24"
```