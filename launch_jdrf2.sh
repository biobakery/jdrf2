#!/bin/bash

IMAGE_ID=$1
test -z "$IMAGE_ID" && { echo "Need an image id"; exit 1; }

sudo docker run \
    --net=bridge \
    -p 80:80 \
    --privileged=true \
    --restart=always \
    -v /var/lib/mysql/mysql.sock:/tmp/mysql.sock \
    -v $(readlink -f etc/jdrf2_nginx.conf):/etc/nginx/nginx.conf \
    --name jdrf $IMAGE_ID > build/weblog 2>&1
