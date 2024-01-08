#!/bin/bash

# DB_ROOT_PASSWORD=$MARIADB_ROOT_USER_PASSWORD
# DB_NAME=$WP_DATABASE_NAME
# DB_USER_NAME=$WP_USER_NAME
# DB_USER_PASSWORD=$WP_USER_PASSWORD

# echo $MARIADB_ROOT_USER_PASSWORD
# echo $WP_DATABASE_NAME
# echo $WP_USER_NAME
# echo $WP_USER_NAME

# Function to test if MariaDB is avalaible
wait_for_mariadb() {
    until mysqladmin ping -h"mariadb" -u"toto" -p"totoisthebest" &> /dev/null; do
        >&2 echo "MariaDB is unavailable - sleeping"
        sleep 2
    done
    >&2 echo "MariaDB is up - executing WordPress setup"
}

# Waiting for MariaDB
wait_for_mariadb

sleep 5

cd $WP_PATH

# Downloading wordpress:
#   This command creates a  folder inside current working directory and downloads the latest WordPress version.

echo "Downloading wordpress using wp-cli..."

wp-cli core download --path=${WP_PATH} --allow-root

echo "Done!"

# Creating config file:
#   Generate a config file wp-config.php for set up the database credentials for our installation.

echo "Creating the config file for the database..."

wp-cli config create    --dbname=${DB_NAME}                     \
                        --dbuser=${DB_USER_NAME}                \
                        --dbpass=${DB_USER_PASSWORD}            \
                        --dbhost=${DB_HOST}                     \
                        --path=${WP_PATH}                  \
                        --allow-root

# Creating the site web
echo "Creating the site web..."

wp-cli core install     --url=${WP_DOMAIN_NAME}                 \
                        --title=${WP_TITLE}                     \
                        --admin_user=${WP_ADMIN_USER}           \
                        --admin_password=${WP_ADMIN_PASSWORD}   \
                        --admin_email=${WP_ADMIN_EMAIL}         \
                        --allow-root


echo "Done!"