#!/bin/sh

set -eo pipefail

#ln -s /usr/bin/php7 /usr/bin/php

if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    ssh-keygen -b 2048 -t rsa -N "" -f /etc/ssh/ssh_host_rsa_key -q
    ssh-keygen -b 256 -t ecdsa -N "" -f /etc/ssh/ssh_host_ecdsa_key -q
    ssh-keygen -b 256 -t ed25519 -N "" -f /etc/ssh/ssh_host_ed25519_key -q
    ssh-keygen -b 1024 -t dsa -N "" -f /etc/ssh/ssh_host_dsa_key -q
fi

if [ -n "$SSH_PUB_KEY" ]; then
	mkdir -p /DATA/.ssh
	echo -e "$SSH_PUB_KEY" > /DATA/.ssh/authorized_keys
        chown www-data:www-data /DATA/.ssh
        chown www-data:www-data /DATA/.ssh/authorized_keys
	chmod 0700 -R /DATA/.ssh
fi
if [ -n "$SSH_PASSWORD" ]; then
        echo "www-data:$SSH_PASSWORD" | chpasswd
fi

if [ ! -f /usr/local/bin/wp-cli ]; then
        curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp-cli && chmod +x /usr/local/bin/wp-cli && chown www-data:www-data /usr/local/bin/wp-cli


fi
exec /usr/sbin/sshd -eD
#exec /usr/bin/ttyd -p 80 -c $WWW_USER:$WWW_PASS su www-data

