# woreguard

## wireguard-go

```bash

mkdir wireguard/{server,peer}
docker run --rm -it ghcr.io/skylens/wireguard-go:latest genskey

docker run -d --name wireguard-go -p 65520:65520 -v wireguard:/etc/wireguard ghcr.io/skylens/wireguard-go:latest
```