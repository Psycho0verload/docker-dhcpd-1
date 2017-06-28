#!/bin/bash

set -e
local _conf_new_folder="/tmp/docker-dhcpd"
local _dhcpd_conf_new="$_conf_new_folder/dhcpd.conf"
local _dhcpd_conf="$PROJECT_HOME/dhcpd.conf"

# copy custom config
[ -f $_dhcpd_conf_new ] && cp $_dhcpd_conf_new $_dhcpd_conf

# checks
[ ! -f $_dhcpd_conf ] && echo "$_dhcpd_conf not found. Exiting ..." && \
exit 1

[ ! -f $PROJECT_HOME/dhcpd.leases ] && touch $PROJECT_HOME/dhcpd.leases

# borrowed from https://github.com/networkboot/docker-dhcpd/blob/master/util/entrypoint.sh
container_id=$(grep docker /proc/self/cgroup | sort -n | head -n 1 | cut -d: -f3 | cut -d/ -f3)
if perl -e '($id,$name)=@ARGV;$short=substr $id,0,length $name;exit 1 if $name ne $short;exit 0' $container_id $HOSTNAME; then
    echo "You must add the 'docker run' option '--net=host' if you want to provide DHCP service to the host network."
fi

# start supervisord
"$@"
