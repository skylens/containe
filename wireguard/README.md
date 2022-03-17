# woreguard

## wireguard-go

### build

```bash
docker build . --file Dockerfile.debian --tag wireguard-go:latest-debian

docker build . --file Dockerfile.apline --tag wireguard-go:latest-apline
```

### 部署

+ docker

```bash
docker run --rm -v /opt/wireguard:/etc/wireguard -it ghcr.io/skylens/wireguard-go:latest-apline gensrv

docker run -d --name wireguard-go --cap-add net_admin -p 65520:65520/udp -v /opt/wireguard:/etc/wireguard wireguard-go:latest-apline
```

+ docker-compose

```bash
cd wireguard
docker run --rm -v /opt/wireguard:/etc/wireguard -it ghcr.io/skylens/wireguard-go:latest-apline gensrv
docker-compose up -d

docker-compose exec wireguard bash
```