FROM php:8.2-cli

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    curl \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    git \
    && docker-php-ext-install pdo pdo_mysql zip

# Instalar o Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copiar os arquivos do projeto
WORKDIR /var/www
COPY . .

# Instalar dependências do Laravel
RUN composer install --no-dev --ignore-platform-req=ext-intl --ignore-platform-req=ext-zip

# Permissões e cache
RUN chmod -R 775 storage bootstrap/cache

# Comando padrão ao rodar o container
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
