# Usar a imagem PHP 8.2
FROM php:8.2-fpm

# Instalar dependências
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip git unzip

# Instalar extensões PHP necessárias
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql

# Definir o diretório de trabalho
WORKDIR /var/www

# Copiar o código do repositório para o contêiner
COPY . .

# Instalar o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalar as extensões PHP necessárias
RUN apt-get update && apt-get install -y \
    libicu-dev \
    zlib1g-dev \
    && docker-php-ext-install intl zip


# Rodar o Composer para instalar dependências
RUN composer install --no-dev

# Definir o comando para rodar o servidor Laravel
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
