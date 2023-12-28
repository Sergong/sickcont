#!/bin/bash

docker run -d \
  --privileged=true \
  --name=sickcont \
  --cap-add=NET_ADMIN \
  --cap-add=NET_RAW \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -p 51820:51820/udp \
  -p 8081:8081 \
  -p 9091:9091 \
  -v ./config:/config \
  -v ./config/data:/downloads \
  -v ./config/tv:/tv \
  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
  --restart unless-stopped \
  docker.io/smeeuwsen/sickcont:latest
