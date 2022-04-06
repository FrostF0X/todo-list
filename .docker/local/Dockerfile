FROM php:8.0-fpm-buster AS base

RUN apt-get update && apt-get install -y \
    moreutils \
    libmcrypt-dev \
    default-mysql-client \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev zip unzip \
    wget \
    libfcgi0ldbl \
    tini \
    nginx \
    procps \
    librabbitmq-dev \
    libssh-dev \
    openssh-server \
    libicu-dev \
    libpq-dev \
    python3-pip \
    postgresql-client
RUN pecl install xdebug amqp
RUN docker-php-ext-enable amqp
RUN docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/
RUN docker-php-ext-configure zip && docker-php-ext-install zip intl
RUN docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && docker-php-ext-install pdo pdo_pgsql pgsql
RUN docker-php-ext-install -j$(nproc) gd
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=2.1.9
RUN curl -sS https://get.symfony.com/cli/installer | bash && ln -s /root/.symfony/bin/symfony /usr/bin/symfony
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g yarn chokidar
RUN echo 'upload_max_filesize=200M' >> /usr/local/etc/php/php.ini
RUN echo 'post_max_size=200M' >> /usr/local/etc/php/php.ini
RUN echo 'memory_limit=268435456' >> /usr/local/etc/php/php.ini
RUN set -xe && echo "pm.status_path = /status" >> /usr/local/etc/php-fpm.d/zz-docker.conf
ADD .docker/local/php/zz-dev.conf /usr/local/etc/php-fpm.d/zz-dev.conf
COPY .docker/local/bin/* /usr/bin/
ADD .docker/local/php/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
ADD .docker/local/nginx/nginx.conf /etc/nginx/nginx.conf
ADD .docker/local/nginx/default.conf /etc/nginx/conf.d/default.conf
RUN chmod +x /usr/bin/*
COPY .docker/local/Makefile /Makefile


WORKDIR /var/www

ARG VERSION
RUN test -n "$VERSION"
ENV VERSION=$VERSION
ENV SHELL="/bin/bash"
ENV NODE_PATH="/usr/lib/node_modules"
ENV PATH="${PATH}:/var/www/vendor/bin:/var/www/tools/*/vendor/bin:/var/www/v2/bin:/var/www/v2/vendor/bin"
ENTRYPOINT ["/usr/bin/tini" ,"--" ,"entrypoint.sh"]
HEALTHCHECK CMD curl -s "http://127.0.0.1/health" || exit 1
CMD ["seed", "run"]
