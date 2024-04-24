# Argumento definido em docker-compose.yml
ARG PHP_IMG_VERSION

# Set master image
FROM ${PHP_IMG_VERSION}

# Argumentos definidos em docker-compose.yml
ARG user
ARG uid
ARG XDEBUG_VERSION
ARG ${DIRECTORY_PATH_APP1}
ARG ${DIRECTORY_PATH_APP2}
ARG ${DIRECTORY_PATH_APP3}

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
    pecl install xdebug-${XDEBUG_VERSION} && \
    docker-php-ext-enable pdo_mysql xdebug

# Instalando Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Criar usuário do sistema para executar comandos do Composer e Artisan
RUN useradd -G www-data,root -u $uid -d /home/$user $user && \
    mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Criar diretórios de trabalho para cada aplicação
RUN mkdir -p /var/www/app1
RUN mkdir -p /var/www/app2
RUN mkdir -p /var/www/app3

# Copiar arquivos de cada aplicação para os respectivos diretórios
COPY ${DIRECTORY_PATH_APP1} /var/www/app1
COPY ${DIRECTORY_PATH_APP2} /var/www/app2
COPY ${DIRECTORY_PATH_APP3} /var/www/app3

# Definir www-data como proprietário dos diretórios de aplicação
RUN chown -R www-data:www-data /var/www/app1 /var/www/app2 /var/www/app3

# Definir permissões de escrita recursivas para www-data
RUN chmod -R 777 /var/www/app1 /var/www/app2 /var/www/app3

# Definindo o diretório de trabalho
WORKDIR /var/www

# Trocando para o usuário especificado em ARG
USER $user

