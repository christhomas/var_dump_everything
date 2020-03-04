ARG PHP_VERSION=7.4

FROM php:${PHP_VERSION}-fpm-alpine AS php

ARG BUILD_DATE="develop"
ARG VCS_REF="develop"
ARG APP_ENV=prod

# The maintainer list
LABEL authors="Chris Alex Thomas <chris.alex.thomas@gmail.com>"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vcs-ref=$VCS_REF

RUN set -eux \
	&& apk add --no-cache acl file gettext git \
	&& apk add --no-cache --virtual .build-deps $PHPIZE_DEPS icu-dev libzip-dev zlib-dev oniguruma-dev \
	&& docker-php-ext-install -j$(nproc) intl exif zip sockets tokenizer mbstring \
	&& pecl install apcu xdebug \
	&& pecl clear-cache \
	&& docker-php-ext-enable xdebug apcu opcache \
	&& runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
	&& apk add --no-cache --virtual .api-phpexts-rundeps $runDeps \
	&& apk del .build-deps

# Configure Basic PHPFPM setup
COPY phpfpm/php.ini /usr/local/etc/php/php.ini

# Configure XDEBUG extension and configuration
COPY phpfpm/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# the zzz in the filename, is to make sure this file is loaded last into the configuration
COPY phpfpm/phpfpm.conf /usr/local/etc/php-fpm.d/zzz_config.conf

COPY . /www
WORKDIR /www

COPY phpfpm/xdebug.sh /xdebug.sh
RUN chmod +x /xdebug.sh

COPY phpfpm/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9000
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
