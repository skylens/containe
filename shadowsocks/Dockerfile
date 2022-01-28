FROM docker.pkg.github.com/skylens/containe/musl-cross-x86-builder:latest AS builder
COPY shadowsocks/build.sh /opt
RUN set -ex; bash /opt/build.sh

FROM debian:stable-slim  
WORKDIR /opt
COPY --from=builder /opt/dist/shadowsocks-libev/bin/ /usr/local/bin
COPY shadowsocks/entrypoint.sh /
 