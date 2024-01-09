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

list_files_installation="/tmp/list_file_install.txt"

ls > /tmp/output_folder

if cmp --silent -- "/tmp/output_folder" "$list_files_installation"; then
  echo "files contents are identical"
else
  echo "files differ"
fi

cat /tmp/output_folder

echo "**************"

cat $list_files_installation

rm /tmp/output_folder

# if [ ! -f "wp-config.php" ]; then
#     # Downloading wordpress:
#     #   This command creates a  folder inside current working directory and downloads
#     echo "Downloading WordPress using wp-cli..."
#     wp-cli core download --path="$WP_PATH" --allow-root
#     echo "Done!"
# fi

# ls 
# if [ -f "wp-config.php" ]; then
#     # Creating config file:
#     #   Generate a config file wp-config.php for set up the database credentials for our installation.
#     echo "Creating the config file for the database..."
#     wp-cli config create    --dbname=${DB_NAME}                     \
#                             --dbuser=${DB_USER_NAME}                \
#                             --dbpass=${DB_USER_PASSWORD}            \
#                             --dbhost=${DB_HOST}                     \
#                             --path=${WP_PATH}                       \
#                             --allow-root
#     echo "Done!"
# fi

# # Creating the site web
# echo "Creating the site web..."
# wp-cli core install     --url=${WP_DOMAIN_NAME}                 \
#                         --title=${WP_TITLE}                     \
#                         --admin_user=${WP_ADMIN_USER}           \
#                         --admin_password=${WP_ADMIN_PASSWORD}   \
#                         --admin_email=${WP_ADMIN_EMAIL}         \
#                         --allow-root

# # Creating WordPress user
# echo "Creating new user ($WP_USER)..."
# wp-cli user create ${WP_USER} ${WP_USER_EMAIL}                  \
#                         --user_pass=${WP_USER_PASSWORD}         \
#                         --role=${WP_USER_ROLE}                  \
#                         --allow-root
# echo "Done!"

# echo "Activating WordPress theme..."

# wp-cli theme activate twentytwentythree --allow-root

php-fpm7.4 -F -R