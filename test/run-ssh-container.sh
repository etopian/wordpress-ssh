#!/bin/bash

docker stop ssh-container-1 && docker rm ssh-container-1
#ssh-keygen -f "/home/user/.ssh/known_hosts" -R [localhost]:2222
docker run -t -v /data/sites/site1.etopian.com/htdocs:/DATA/htdocs --name=ssh-container-1 -e SSH_PASSWORD=jkljdjIOIU -e WWW_USER=user -e WWW_PASS=pass -p 2222:22 etopian/wordpress-ssh
