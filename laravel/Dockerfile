FROM php:8.3-cli

# Cài đặt các thư viện hệ thống cần thiết cho MySQL, PostgreSQL và Composer
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    zip \
    unzip

# Xoá cache apt để giảm dung lượng
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Cài đặt các Extension PHP (Lưu ý: Đã thêm pdo_pgsql cho Render)
RUN docker-php-ext-install pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd

# Copy Composer từ image chính thức
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# Copy toàn bộ mã nguồn Laravel vào container
COPY . .

# Phân quyền cho thư mục storage và bootstrap/cache
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 /var/www/storage \
    && chmod -R 775 /var/www/bootstrap/cache

# Cài đặt các gói PHP (Bỏ qua môi trường dev để nhẹ và nhanh hơn trên production)
RUN composer install --optimize-autoloader --no-dev

# Xoá cache cấu hình cũ
RUN php artisan config:clear || true

# Render sẽ cấp biến môi trường $PORT (thường là ngẫu nhiên), Laravel sẽ chạy trên PORT đó
CMD php artisan migrate --force --seed && php artisan serve --host=0.0.0.0 --port=${PORT:-8000}
