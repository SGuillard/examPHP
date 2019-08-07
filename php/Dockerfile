ARG PHP_VERSION=${PHP_VERSION}
ARG DEBIAN_VERSION=${DEBIAN_VERSION}
FROM php:${PHP_VERSION}-${DEBIAN_VERSION}

# Install PHP extensions
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  curl \
  git \
  vim \
  wget \
  zip \
  unzip \
  ssmtp \
  libmemcached-dev \
  libz-dev \
  libpq-dev \
  libjpeg-dev \
  libpng-dev \
  libfreetype6-dev \
  libssl-dev \
  libmcrypt-dev \
  mysql-client

# Pour que la fonction easter_date fonctionne
RUN docker-php-ext-configure calendar && docker-php-ext-install calendar

# Install the PHP default extention
RUN docker-php-ext-install pdo_mysql mysqli

# Install the PHP gd library
RUN docker-php-ext-configure gd \
  --enable-gd-native-ttf \
  --with-jpeg-dir=/usr/lib \
  --with-freetype-dir=/usr/include/freetype2 && \
  docker-php-ext-install gd

###########################################################################
# xDebug:
###########################################################################

ARG INSTALL_XDEBUG=false

RUN if [ ${INSTALL_XDEBUG} = true ]; then \
  # Install the xdebug extension
  if [ $(php -r "echo PHP_MAJOR_VERSION;") = "5" ]; then \
  pecl install xdebug-2.5.5; \
  else \
  pecl install xdebug; \
  fi && \
  docker-php-ext-enable xdebug \
  ;fi

# Copy xdebug configuration for remote debugging
# COPY ./ini/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

###########################################################################
# Opcache:
###########################################################################

ARG INSTALL_OPCACHE=false

RUN if [ ${INSTALL_OPCACHE} = true ]; then \
  docker-php-ext-install opcache \
  ;fi

# Copy opcache configration
COPY ./ini/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

###########################################################################
# Composer:                                                           
###########################################################################

ARG INSTALL_COMPOSER=false

RUN wget https://cs.symfony.com/download/php-cs-fixer-v2.phar -O php-cs-fixer && \
  chmod a+x php-cs-fixer && \
  mv php-cs-fixer /usr/local/bin/php-cs-fixer	

RUN if [ ${INSTALL_COMPOSER} = true ]; then \
  curl -sS https://getcomposer.org/installer | php \
  && mv composer.phar /usr/local/bin/ \
  && ln -s /usr/local/bin/composer.phar /usr/local/bin/composer \
  ;fi

USER root

# Clean up
RUN apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
  rm /var/log/lastlog /var/log/faillog

CMD ["php-fpm"]

EXPOSE 9000
