FROM alpine:latest
ENV SERVER_ADDR=0.0.0.0
ENV SERVER_PORT=8388
ENV PASSWORD=
ENV METHOD=aes-256-gcm
ENV TIMEOUT=300
ENV DNS_ADDRS=8.8.8.8,8.8.4.4
ENV TZ=UTC
ENV ARGS=
COPY . /tmp/repo 
# buildkit
RUN set -ex  && apk add --no-cache --virtual .build-deps \
autoconf \
automake \
build-base \
c-ares-dev \
libcap \
libev-dev \
libtool \
libsodium-dev \
linux-headers \
mbedtls-dev \
pcre-dev \
&& cd /tmp/repo \
&& ./autogen.sh \
&& ./configure --prefix=/usr --disable-documentation \
&& make install \
&& ls /usr/bin/ss-* | xargs -n1 setcap cap_net_bind_service+ep \
&& apk del .build-deps \
&& apk add --no-cache \
ca-certificates \
rng-tools \
tzdata \
$(scanelf --needed --nobanner /usr/bin/ss-* | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' | sort -u) \
&& rm -rf /tmp/repo 
# buildkit
USER nobody
CMD ["/bin/sh" "-c" "exec ss-server -s $SERVER_ADDR -p $SERVER_PORT -k ${PASSWORD:-$(hostname)} -m $METHOD -t $TIMEOUT -d $DNS_ADDRS -u $ARGS"]