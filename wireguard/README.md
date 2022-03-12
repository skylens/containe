# woreguard

## wireguard-go

```bash

mkdir wireguard
docker run --rm -v wireguard:/etc/wireguard -it ghcr.io/skylens/wireguard-go:latest gensrv

docker run -d --name wireguard-go -p 65520:65520 -v wireguard:/etc/wireguard ghcr.io/skylens/wireguard-go:latest
```