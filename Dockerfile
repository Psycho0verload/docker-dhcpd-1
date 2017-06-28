FROM       alpine:latest
MAINTAINER Paul Steinlechner <paul.steinlechner@pylonlabs.at>

ENV PROJECT_HOME=/docker-dhcpd

RUN set -xe \
&& apk add --update --no-progress dhcp supervisor \
&& rm -rf /var/cache/apk/*

# Add files
ADD util/entrypoint.sh /entrypoint.sh
ADD util/supervisord.conf /etc/supervisor/supervisord.conf
ADD util/dhcpd.conf /etc/supervisor/conf.d/dhcpd.conf

# Expose needed ports
EXPOSE 67/udp 67/tcp

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
cmd ["/usr/bin/supervisord"]
