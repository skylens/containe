FROM ghcr.io/skylens/musl-cross-x64-builder:latest AS builder
COPY build.sh /opt
RUN set -ex; bash /opt/build.sh

FROM golang:1.17.6-buster AS pluginsbuilder
COPY v2ray/v2ray-build.sh /opt
COPY gost/gost-build.sh /opt
COPY Cloak/cloak-build.sh /opt
RUN set -ex; bash /opt/v2ray-build.sh
RUN set -ex; bash /opt/gost-build.sh
RUN set -ex; bash /opt/cloak-build.sh

FROM debian:stable-slim
WORKDIR /opt
COPY --from=builder /opt/dist/shadowsocks-libev/bin/ /usr/local/bin
COPY --from=pluginsbuilder /opt/dist/release/v2ray-plugin/linux/v2ray-plugin /usr/local/bin/
COPY --from=pluginsbuilder /opt/dist/release/gost-plugin/linux/gost-plugin /usr/local/bin/
COPY --from=pluginsbuilder /opt/dist//release/Cloak/linux/ck-server /usr/local/bin/
COPY entrypoint.sh /
 