# Usando imagem oficial do PHP
FROM php:8.1-fpm

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    git \
    curl \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo pdo_mysql zip \
    && rm -rf /var/lib/apt/lists/*

# Instalar o Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Definir o diretório de trabalho
WORKDIR /var/www

# Copiar os arquivos do projeto para o container
COPY . .

# Instalar as dependências do Laravel
RUN composer install --no-dev

# Expor a porta 9000 para a aplicação
EXPOSE 9000

# Iniciar o servidor PHP
CMD ["php-fpm"]
