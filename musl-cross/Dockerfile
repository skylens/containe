FROM debian:stable AS builder
RUN set -e apt-get update -y
RUN set -e apt-get install -y --no-install-recommends git wget build-essential binutils ca-certificates
RUN update-ca-certificates
RUN set -e cd ~/ && git clone https://github.com/richfelker/musl-cross-make.git
RUN set -e cd ~/musl-cross-make
COPY config.mk ~/musl-cross-make
RUN set -e make && make install

FROM debian:stable  
WORKDIR /root/
COPY --from=builder /opt/* /opt