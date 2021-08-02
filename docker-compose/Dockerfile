# Criado por: Francisco - gomes.tisystem@gmail.com.
# Set master image
FROM php:7.4-fpm

# Arguments defined in docker-compose.yml
ARG user=$USER
ARG uid=1000

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    apt-utils \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    libldap2-dev \
    libxml2-dev \
    libmagickwand-dev --no-install-recommends \
    && pecl install imagick \
    xdebug

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions, configure and enable
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
&& docker-php-ext-install gd dom opcache pdo ldap pdo_mysql mysqli mbstring exif pcntl soap bcmath json \
&& docker-php-ext-enable pdo_mysql imagick xdebug

# Add UID '1000' to www-data
#RUN usermod -u 1000 www-data

#Copy existing application directory permissions
#COPY --chown=www-data:www-data . /var/www

# Change current user to www
#USER www-data

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Set working directory
WORKDIR /var/www

USER $user

# Expose port 9000 and start php-fpm server
#EXPOSE 9000
#CMD ["php-fpm"]