#!/bin/bash

NGINX_IP=`dig +short $NGINX_NAME`

/bin/bash -c "sed 's|NGINX_HOST|"$NGINX_HOST"|g;s|NGINX_IP|"$NGINX_IP"|g' -i /etc/dnsmasq.d/dns.records"

systemctl restart dnsmasq
