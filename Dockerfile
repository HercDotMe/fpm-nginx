FROM php:8.3-fpm

# Define ENV variables
ENV SERVER_PORT=80
ENV INDEX_FILE='index.php'
ENV ERR_LOG_PATH='/var/log/nginx/error.log'
ENV ACC_LOG_PATH='/var/log/nginx/access.log'
ENV DOCUMENT_ROOT='/var/www/public'
ENV FPM_CONTAINER_NAME='php-fpm'
ENV FPM_CONTAINER_PORT=9000

# Arguments
ARG APCU_VERSION=5.1.11

# Update image packages
RUN apt-get update -y && apt-get install -y nginx

# Install APCu
RUN pecl install apcu \
  && docker-php-ext-enable apcu

# Add Docker PHP Extensions
RUN docker-php-ext-install pdo_mysql \
    && docker-php-ext-install opcache \
    && apt-get install libicu-dev -y \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && apt-get remove libicu-dev icu-devtools -y
RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=2'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/php-opocache-cfg.ini

# Copy config file
COPY nginx.conf /etc/nginx/conf.d/nginx_conf_template

# Copy entry file
WORKDIR /etc/nginx
COPY entrypoint.sh ./entrypoint.sh
RUN ["chmod", "+x", "./entrypoint.sh"]

# Expose port
EXPOSE ${SERVER_PORT}

ENTRYPOINT ["./entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
