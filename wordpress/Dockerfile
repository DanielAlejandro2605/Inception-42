# Use the latest Debian base image
FROM debian:bullseye

# Update apt-get packages
RUN apt-get update

# Install php
RUN apt-get install php php-mysql php-fpm php-common php-curl -y

# Install curl
RUN apt-get install curl -y

# Requesting WP-CLI (WordPress Command Line Interface)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

# Start PHP-FPM as the default command
CMD ["php", "wp-cli.phar", "--info"]

