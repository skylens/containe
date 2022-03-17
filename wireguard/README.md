# woreguard

## wireguard-go

```bash

mkdir wireguard



docker run --rm -v /opt/wireguard:/etc/wireguard -it ghcr.io/skylens/wireguard-go:latest gensrv

docker run -d --name wireguard-go -p 65520:65520 -v /opt/wireguard:/etc/wireguard ghcr.io/skylens/wireguard-go:latest

docker build . --file Dockerfile --tag wireguard-go:latest

docker run --rm -v /opt/wireguard:/etc/wireguard -it ghcr.io/skylens/wireguard-go:latest gensrv

docker run -d --name wireguard-go --cap-add net_admin --cap-add sys_module -p 65520:65520 -v /opt/wireguard:/etc/wireguard wireguard-go:latest

docker run -d --name wireguard-go --cap-add net_admin --cap-add sys_module -p 65520:65520/udp -v /dev/net/tun:/dev/net/tun wireguard-go:latest-apline
```