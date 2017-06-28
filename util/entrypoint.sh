#!/bin/bash

set -e

_conf_new_folder="/tmp/docker-dhcpd"
_dhcpd_conf_new="$_conf_new_folder/dhcpd.conf"
_dhcpd_conf="$PROJECT_HOME/dhcpd.conf"
_dhcpd_lease="$PROJECT_HOME/dhcpd.lease"

# copy custom config
[ -f $_dhcpd_conf_new ] && cp $_dhcpd_conf_new $_dhcpd_conf

# checks
[ ! -f $_dhcpd_conf ] && echo "$_dhcpd_conf not found. Exiting ..." && \
exit 1

[ ! -f $_dhcpd_lease ] && touch $_dhcpd_lease

# start supervisord
"$@"
