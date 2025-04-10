FROM php:7.4-apache
RUN docker-php-ext-install -j$(nproc) mysqli

RUN chown -R www-data:www-data /var/www/html/ && \
chmod -R 755 /var/www/html/ && \
echo "DirectoryIndex index.php index.html" > /etc/apache2/conf-available/directoryindex.conf && \
a2enconf directoryindex

COPY connect.php /var/www/html/