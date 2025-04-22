# Usando a imagem oficial PHP 8.2
FROM php:8.2-fpm

# Instalar dependências do sistema e extensões PHP necessárias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    git \
    curl \
    unzip \
    libicu-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip intl \
    && rm -rf /var/lib/apt/lists/*

# Instalar o Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Definir o diretório de trabalho
WORKDIR /var/www

# Copiar os arquivos do projeto para o container
COPY . .

# Instalar as dependências do Laravel
RUN composer install --no-dev

# Expor a porta 9000 para o PHP-FPM
EXPOSE 9000

# Iniciar o servidor PHP-FPM
CMD ["php-fpm"]
