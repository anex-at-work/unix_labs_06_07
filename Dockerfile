FROM vlavad/lab00
MAINTAINER anex.work@gmail.com

RUN yum -y install dnsmasq bind-utils &&\
    systemctl enable dnsmasq.service

ADD ./assets/dnsmasq/dnsmasq.conf /etc/dnsmasq.conf
ADD ./assets/dnsmasq/dns.records /etc/dnsmasq.d/dns.records
ADD ./assets/dnsmasq/dns_rewrite.sh /root/dns_rewrite.sh

