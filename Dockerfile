FROM php:5.6-apache

RUN apt-get update && apt-get install -y \
      libicu-dev \
      libpq-dev \
      libmcrypt-dev \
      mysql-client \
      git \
      zip \
      unzip \
      libfreetype6-dev \
      libpng-dev \
      libjpeg-dev \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
      intl \
      mcrypt \
      pcntl \
      pdo_mysql \
      pdo_pgsql \
      pgsql \
      gd

ENV APP_HOME /var/www/html

RUN usermod -u 1000 www-data && groupmod -g 1000 www-data

RUN a2enmod rewrite

RUN chown -R www-data:www-data $APP_HOME

COPY 000-default.conf /etc/apache2/sites-available/
COPY default-ssl.conf /etc/apache2/sites-available/
COPY php.ini /usr/local/etc/php/

