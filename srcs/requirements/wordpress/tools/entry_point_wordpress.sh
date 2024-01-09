#!/bin/bash

# Function to test if MariaDB is avalaible
wait_for_mariadb() {
    until mysqladmin ping -h${DB_HOST} -u${DB_USER_NAME} -p${DB_USER_PASSWORD} &> /dev/null; do
        >&2 echo "MariaDB is unavailable - sleeping"
        sleep 2
    done
    >&2 echo "MariaDB is up - executing WordPress setup"
}

# Waiting for MariaDB
wait_for_mariadb

sleep 5

cd $WP_PATH

if [ -d "$WP_PATH" ]; then
    if [ ! "$(ls -A "$WP_PATH")" ]; then
        # Downloading wordpress:
        #   This command creates a  folder inside current working directory and downloads
        echo "Downloading WordPress using wp-cli..."
        wp-cli core download --path="$WP_PATH" --allow-root
        echo "Done!"
    fi
fi

if [ ! -f "${WP_PATH}/wp-config.php" ]; then
    # Creating config file:
    #   Generate a config file wp-config.php for set up the database credentials for our installation.
    echo "Creating the config file for the database..."
    wp-cli config create    --dbname=${DB_NAME}                     \
                            --dbuser=${DB_USER_NAME}                \
                            --dbpass=${DB_USER_PASSWORD}            \
                            --dbhost=${DB_HOST}                     \
                            --path=${WP_PATH}                  \
                            --allow-root
    echo "Done!"
fi

# Creating the site web
echo "Creating the site web..."
wp-cli core install     --url=${WP_DOMAIN_NAME}                 \
                        --title=${WP_TITLE}                     \
                        --admin_user=${WP_ADMIN_USER}           \
                        --admin_password=${WP_ADMIN_PASSWORD}   \
                        --admin_email=${WP_ADMIN_EMAIL}         \
                        --allow-root

echo "Done!"