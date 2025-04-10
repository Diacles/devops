FROM php:7.4-apache
RUN docker-php-ext-install -j$(nproc) mysqli
COPY connect.php /var/www/html/