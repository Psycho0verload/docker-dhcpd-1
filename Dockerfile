FROM       resin/armv7hf-debian-qemu:latest
MAINTAINER Paul Steinlechner <paul.steinlechner@pylonlabs.at>

ENV DEBIAN_FRONTEND=noninteractive PROJECT_HOME=/opt/docker-dhcpd

RUN [ "cross-build-start" ]

RUN apt-get update && \
    apt-get install -q -y -o "DPkg::Options::=--force-confold" apt-utils && \
    apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" dist-upgrade && \
    apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install isc-dhcp-server man supervisor && \
    apt-get -q -y autoremove && \
    apt-get -q -y clean && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p $PROJECT_HOME

# Add files
ADD util/entrypoint.sh /entrypoint.sh
ADD util/supervisord.conf /etc/supervisor/supervisord.conf
ADD util/supervisord_dhcpd.conf /etc/supervisor/conf.d/dhcpd.conf

# Expose needed ports
EXPOSE 67/udp 67/tcp

RUN chmod +x /entrypoint.sh

RUN [ "cross-build-end" ]

ENTRYPOINT ["/entrypoint.sh"]
cmd ["/usr/bin/supervisord"]
