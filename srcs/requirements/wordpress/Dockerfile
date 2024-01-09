# Use the latest Debian base image
FROM debian:bullseye

# Update apt-get packages
RUN apt-get update

# Install php
# RUN apt-get install php php-mysql php-fpm php-common php-curl -y
RUN apt-get install php php-mysql php-fpm mariadb-client -y

# Install curl
RUN apt-get install curl -y

# Requesting WP-CLI (WordPress Command Line Interface)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Making the WP-CLI executable
RUN chmod +x wp-cli.phar

# Adding the WP-CLI as executable in the Docker Container
RUN mv wp-cli.phar /usr/local/bin/wp-cli

# Creating folder for WordPress
RUN mkdir /var/www/
RUN mkdir /var/www/html

# Copy the config for general PHP request
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

# Copy the ENTRYPOINT Script that will be executed 
COPY ./tools/entry_point_wordpress.sh /

# Making the ENTRYPOINT Script executable
RUN chmod +x /entry_point_wordpress.sh

# Lauch the script after the container is initiated. 
ENTRYPOINT ["/entry_point_wordpress.sh"]
