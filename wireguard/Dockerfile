FROM golang:1.17.8-buster AS gobuilder
COPY wireguard-go-build.sh /opt
RUN set -ex; bash /opt/wireguard-go-build.sh

FROM debian:stable-slim
COPY --from=gobuilder /usr/bin/wireguard* /usr/local/bin/
RUN set -ex; [[ ! -d "/etc/wireguard" ]] && mkdir /etc/wireguard || echo "directory exit!!!"
COPY installdeps.sh /opt/
COPY gensrv /usr/local/bin/
COPY *.tmpl /opt/
RUN set -ex; bash /opt/installdeps.sh
COPY entrypoint.sh /

CMD ["/entrypoint.sh"]