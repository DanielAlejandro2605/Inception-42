#!/bin/bash

# Path to the file which contains the list of downloaded files
download_file_list_file="/tmp/download_file_list.txt"

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


if [ ! -f "wp-config.php" ]; then
    ls > /tmp/current_state.txt
    # Downloading wordpress:
    #   This command creates a  folder inside current working directory and downloads
    if cmp --silent -- "/tmp/current_state.txt" "$download_file_list_file"; then
      echo "The current status of the directory indicates that the download is done!"
    else
      echo "Downloading WordPress using wp-cli..."
      wp-cli core download --path="$WP_PATH" --allow-root
      echo "Done!"
    fi

    # Creating config file:
    #   Generate a config file wp-config.php for set up the database credentials for our installation.
    echo "Creating the config file for the database..."
    wp-cli config create    --dbname=${DB_NAME}                     \
                            --dbuser=${DB_USER_NAME}                \
                            --dbpass=${DB_USER_PASSWORD}            \
                            --dbhost=${DB_HOST}                     \
                            --path=${WP_PATH}                       \
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


check=$(wp-cli user list --field=user_login --allow-root | grep $WP_USER)
if [ $check == $WP_USER ]; then
    echo "The user is already register!"
else
    # Creating WordPress user
    echo "Creating new user ($WP_USER)..."
    wp-cli user create ${WP_USER} ${WP_USER_EMAIL}                  \
                            --user_pass=${WP_USER_PASSWORD}         \
                            --role=${WP_USER_ROLE}                  \
                            --allow-root
    echo "Done!"
fi

wp-cli theme activate twentytwentythree --allow-root

php-fpm7.4 -F -R