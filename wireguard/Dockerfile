FROM ghcr.io/skylens/musl-cross-x64-builder:latest AS builder
COPY build.sh /opt
RUN set -ex; bash /opt/build.sh

FROM golang:1.17.8-buster AS gobuilder
COPY wireguard-go-build.sh /opt
RUN set -ex; bash /opt/wireguard-go-build.sh

FROM debian:stable-slim
COPY --from=builder /usr/bin/wg* /usr/local/bin/
COPY --from=builder /usr/local/bin/qr /usr/local/bin/
COPY --from=gobuilder /usr/bin/wg* /usr/local/bin/
RUN set -ex; [[ ! -d "/etc/wireguard" ]] && mkdir /etc/wireguard || echo "directory exit!!!"
COPY installdeps.sh /opt/
COPY wg* /opt/
RUN set -ex; bash /opt/installdeps.sh
COPY genskey /usr/bin/genskey
COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]