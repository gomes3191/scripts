# Criado por: Francisco - gomes.tisystem@gmail.com.

# Argumento definido em docker-compose.yml
ARG PHP_IMG_VERSION

# Set master image
FROM ${PHP_IMG_VERSION}

# Argumentos definidos em docker-compose.yml
ARG user
ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    apt-utils \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip libzip-dev \
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
&& docker-php-ext-configure zip \
&& docker-php-ext-install zip gd dom opcache pdo ldap pdo_mysql mysqli mbstring exif pcntl soap bcmath json \
&& docker-php-ext-enable pdo_mysql imagick xdebug

#-----------------
# Add UID '1000' to www-data
#RUN usermod -u 1000 www-data

#Copy existing application directory permissions
#COPY --chown=www-data:www-data . /var/www

# Change current user to www
#USER www-data

# Obtém o composer mais recente
#COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
#----------------------------------

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Criar usuário do sistema para executar comandos do Composer e Artisan
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && chown -R $user:$user /home/$user

# Defini diretório de trabalho
WORKDIR /var/www

USER $user
