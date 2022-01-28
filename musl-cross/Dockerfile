FROM debian:stable AS builder
RUN set -xe; apt-get update -y
RUN set -xe; apt-get install -y --no-install-recommends git wget build-essential binutils ca-certificates
RUN set -xe; update-ca-certificates --fresh
RUN set -xe; cd ~/ && git clone https://github.com/richfelker/musl-cross-make.git
RUN set -ex; cd ~/musl-cross-make && wget https://raw.githubusercontent.com/skylens/containe/main/musl-cross/config.mak
RUN set -xe; cd ~/musl-cross-make && make && make install

FROM debian:stable-slim  
WORKDIR /opt
COPY --from=builder /opt/ /opt