# Use the official PHP 8.2 image as a base with Apache
FROM php:8.2-apache

# Install dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    unzip \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libonig-dev \
    libxslt1-dev \
    libcurl4-openssl-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpq-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) intl zip pdo pdo_mysql mbstring curl xml simplexml gd mysqli bcmath

# Enable Apache modules and configure virtual host
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Copy composer.lock and composer.json
#COPY ../composer.json /var/www/html/
# Copy the application files
COPY ./ /var/www/html

# Install composer dependencies if needed
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
COPY ./composer.json /var/www/html/
#RUN composer config -g repos.packagist composer https://mirrors.cloud.tencent.com/composer/
RUN composer config -g process-timeout 2000
RUN composer install --prefer-dist --optimize-autoloader

# Change ownership of the working directory to the Apache user
RUN chown -R www-data:www-data /var/www/html

# Expose port 80
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
