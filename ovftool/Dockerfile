FROM ubuntu:22.04
ENV ovftool_download_link https://ftp.skylens.co/VMware-ovftool-4.3.0-15755677-lin.x86_64.bundle
RUN set -ex; apt update;apt install wget libncursesw5 -y
RUN set -ex; wget -O /tmp/VMware-ovftool-lin.x86_64.bundle ${ovftool_download_link}
RUN set -ex; chmod +x /tmp/VMware-ovftool-lin.x86_64.bundle && /tmp/VMware-ovftool-lin.x86_64.bundle --console --required --eulas-agreed
