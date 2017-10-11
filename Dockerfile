FROM alpine:edge
MAINTAINER Etopian <contact@etopian.com>

# Create user www-data
RUN addgroup -g 101 -S www-data && \
	adduser -s /bin/bash -u 100 -D -S -G www-data www-data -h /DATA

# Install packages
RUN echo 'http://dl-4.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories\
    && apk update \
    && apk --no-cache add bash less vim ca-certificates \
    php7-json php7-zlib php7-xml php7-pdo php7-phar php7-openssl \
    php7-pdo_mysql php7-mysqli php7-session \
    php7-gd php7-iconv php7-mcrypt \
    php7-curl php7-opcache php7-ctype php7-apcu \
    openssl git wget openssh rsync \
    php7-intl php7-bcmath php7-dom php7-xmlreader mysql-client curl && apk add -u musl ttyd


# Create work dir
WORKDIR /DATA
VOLUME ["/DATA/htdocs", "/DATA/logs", "/DATA/backups"]

ENV TERM=linux SSH_PUB_KEY= SSH_PASSWORD=changeme! WWW_USER=user WWW_PASS=pass

EXPOSE 22 80

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp-cli && chmod +x /usr/local/bin/wp-cli && chown www-data:www-data /usr/local/bin/wp-cli


LABEL   devoply.type="ssh" \
        devoply.cms="wordpress" \
        devoply.framework="wordpress" \
        devoply.language="shell" \
        devoply.require="" \
        devoply.recommend="" \
        devoply.description="OpenSSH image to use with the WordPress container." \
        devoply.name="OpenSSH with WP-CLI, PHP 7, and mysql cient" \
        devoply.params=""




COPY docker-entrypoint.sh /usr/local/bin/
CMD "/usr/local/bin/docker-entrypoint.sh"
