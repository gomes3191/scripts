# Criado por: Francisco Aparecido - [gomes.tisystem@gmail.com]

# Argumentos de compilação
ARG user
ARG uid
ARG PHP_IMG_VERSION
ARG XDEBUG_VERSION
ARG DEFAULT_XDEBUG_VERSION="3.0.2"


# Usando uma imagem base leve do PHP
FROM ${PHP_IMG_VERSION}

# Instalando dependências e limpando o cache
RUN apt-get update && \
    apt-get install -y \
    git curl apt-utils \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip libzip-dev \
    unzip libldap2-dev \
    libmagickwand-dev --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configurando extensões do PHP
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu && \
    docker-php-ext-configure zip && \
    docker-php-ext-install zip gd dom \
    opcache pdo ldap pdo_mysql mysqli mbstring \
    exif pcntl soap bcmath json && \
    pecl install xdebug-3.0.2 && \
    docker-php-ext-enable pdo_mysql xdebug

# Instalando Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Criando o usuário do sistema
RUN useradd -G www-data,root -u $UID -d /home/$USER $USER && \
    mkdir -p /home/$USER/.composer && \
    chown -R $USER:$USER /home/$USER

# Definindo o diretório de trabalho
WORKDIR /var/www

# Trocando para o usuário especificado em ARG
USER $USER

