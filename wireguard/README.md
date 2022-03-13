# woreguard

## wireguard-go

```bash

mkdir wireguard
docker run --rm -v /opt/wireguard:/etc/wireguard -it ghcr.io/skylens/wireguard-go:latest gensrv

docker run -d --name wireguard-go -p 65520:65520 -v /opt/wireguard:/etc/wireguard ghcr.io/skylens/wireguard-go:latest
```