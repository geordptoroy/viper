# Usar a imagem PHP 8.2
FROM php:8.2-fpm

# Instalar dependências e extensões PHP necessárias
RUN apt-get update && apt-get install -y \
    libicu-dev \
    zlib1g-dev \
    && docker-php-ext-install intl zip

# Instalar o Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Definir o diretório de trabalho
WORKDIR /var/www

# Copiar os arquivos do projeto
COPY . .

# Rodar o Composer para instalar dependências
RUN composer install --no-dev --ignore-platform-req=ext-intl --ignore-platform-req=ext-zip

# Definir o comando para rodar o servidor Laravel
CMD ["php-fpm"]
