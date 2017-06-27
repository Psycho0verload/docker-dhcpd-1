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

# start supervisord
"$@"
