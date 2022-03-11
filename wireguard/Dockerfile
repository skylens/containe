FROM ghcr.io/skylens/musl-cross-x64-builder:latest AS builder
COPY build.sh /opt
RUN set -ex; bash /opt/build.sh

FROM golang:1.17.6-buster AS gobuilder
COPY wireguard-go-build.sh /opt
RUN set -ex; bash /opt/wireguard-go-build.sh

FROM debian:stable-slim
COPY --from=builder /usr/bin/wg* /usr/local/bin/
COPY --from=gobuilder /usr/bin/wg* /usr/local/bin/
RUN set -ex; /etc/wireguard
COPY entrypoint.sh /entrypoint.sh

CMD ["/entrypoint.sh"]