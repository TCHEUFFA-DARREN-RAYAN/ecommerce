# Use official PHP 8.2 with Apache
FROM php:8.2-apache

# Install required PHP extensions
RUN docker-php-ext-install pdo pdo_mysql

# Enable Apache mod_rewrite (needed by Laravel routes)
RUN a2enmod rewrite

# Install Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Copy project files
COPY . .

# Install dependencies
RUN composer install --no-dev --optimize-autoloader

# Laravel storage & cache permissions
RUN chmod -R 775 storage bootstrap/cache

# Set Apache DocumentRoot to Laravel public/
WORKDIR /var/www/html/public

CMD ["apache2-foreground"]
