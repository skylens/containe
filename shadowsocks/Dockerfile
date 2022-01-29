FROM ghcr.io/skylens/musl-cross-x64-builder:latest AS builder
COPY build.sh /opt
RUN set -ex; bash /opt/build.sh

FROM debian:stable-slim
WORKDIR /opt
COPY --from=builder /opt/dist/shadowsocks-libev/bin/ /usr/local/bin
COPY entrypoint.sh /
 