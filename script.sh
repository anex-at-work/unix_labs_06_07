#!/bin/bash

NETWORK=simple_network
NGINX_HOST=lxc02.z2442

start(){
  echo "Creating network "$NETWORK
  docker network create $NETWORK
  echo "Creating container "
  docker build -f Dockerfile.nginx -t docker_nginx_build .
  docker run --env NGINX_HOST=$NGINX_HOST --name docker_nginx -v $PWD/html/:/var/www/ -v $PWD/assets/nginx/:/tmp/nginx/ --net $NETWORK -d docker_nginx_build
  docker build -t docker_lab_build .
  docker run --env NGINX_HOST=$NGINX_HOST --env NGINX_NAME=docker_nginx --name docker_dns --privileged -p 127.0.0.1:53:53/tcp -p 127.0.0.1:53:53/udp --net $NETWORK -d docker_lab_build
  docker exec docker_dns bash -c "chmod o+x /root/dns_rewrite.sh && /root/dns_rewrite.sh"
}

stop(){
  echo "Removing containers"
  docker stop docker_nginx
  docker rm docker_nginx
  docker stop docker_dns
  docker rm docker_dns
  echo "Removing network "$NETWORK
  docker network rm $NETWORK
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  *)
    echo "Usage: ./script.sh  (start|stop)"
    ;;
esac
