#!/bin/bash

echo "Downloading wordpress using wp-cli..."

# Downloading wordpress:
#   This command creates a wpdemo.test/ folder inside current working directory and downloads the latest WordPress version.

wp-cli core download --path='wpdemo.test' --allow-root

echo "Done!"

echo "Creating the config file for the database..."

# Creating config file:
#   Generate a config file wp-config.php for set up the database credentials for our installation.

wp-cli config create     \
    --dbhost='localhost' \
    --dbname='wordpress' \
    --dbuser='daniel'    \
    --dbpass='089765'    \
    --path='wpdemo.test' \
    --allow-root

echo "Done!"

ls

