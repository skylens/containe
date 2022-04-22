FROM debian:stable-slim AS builder
ENV vmware_download_link https://download3.vmware.com/software/WKST-1623-LX-New/VMware-Workstation-Full-16.2.3-19376536.x86_64.bundle
RUN set -ex; apt update;apt install wget -y
RUN set -ex; wget -O /tmp/VMware-Workstation-Full.bundle ${vmware_download_link}
RUN set -ex; chmod +x /tmp/VMware-Workstation-Full.bundle && /tmp/VMware-Workstation-Full.bundle

FROM debian:stable-slim
COPY --from=builder /usr/lib/vmware-ovftool/ovftool/* /usr/local/bin/
