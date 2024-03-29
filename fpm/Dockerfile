FROM php:8.1-fpm

# install the PHP extensions we need
RUN apt-get update \
        && apt-get install -y libonig-dev libpng-dev libjpeg-dev libzip-dev \
        && rm -rf /var/lib/apt/lists/* \
        && docker-php-ext-configure gd --with-jpeg \
        && docker-php-ext-install -j$(nproc) exif gd mbstring mysqli opcache zip \
        && pecl install apcu \
        && docker-php-ext-enable apcu

RUN { \
        echo '[apcu]'; \
        echo 'extension = apcu.so'; \
        echo 'apc.enabled = 1'; \
        echo 'apc.enable_cli = 0'; \
        echo 'apc.shm_size = 64M'; \
        echo 'apc.mmap_file_mask = /tmp/apc.XXXXXX'; \
        echo '[apc]'; \
        echo 'extension = apc.so'; \
    } > /usr/local/etc/php/conf.d/apcu.ini

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=60'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache.ini

EXPOSE 9000
CMD ["php-fpm"]
