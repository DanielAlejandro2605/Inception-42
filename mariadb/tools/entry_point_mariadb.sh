#!/bin/bash

ROOT_PASSWORD="089765"
WP_USER_NAME="toto"
WP_USER_PASSWORD="totoisthebest"
WP_DATABASE_NAME="wordpress"

# Path to the original SQL script
SQL_SCRIPT="/secure_init_db.sql"

# Run mysqld with the modified SQL script
mysqld --bootstrap --init-file="$SQL_SCRIPT"

# Start MariaDB
service mariadb start
sleep 2

# Create database for wordpress
echo " (*) Creating ${WP_DATABASE_NAME} database ..."
mysql -e "CREATE DATABASE IF NOT EXISTS $WP_DATABASE_NAME;"

# Create user for wordpress database
echo " (*) Creating user ${WP_USER_NAME} ... "
# localhost o '%' ?
mysql -e "CREATE USER '$WP_USER_NAME'@'%' IDENTIFIED BY '$WP_USER_PASSWORD';"

# Grant privileges for wordpress user database to the wordpress database
echo " (*) Grant privileges for ${WP_USER_NAME} on ${WP_DATABASE_NAME} ... "
mysql -e "GRANT ALL PRIVILEGES ON $WP_DATABASE_NAME.* TO '$WP_USER_NAME'@'%' IDENTIFIED BY '$WP_USER_PASSWORD';"

# Save the privileges 
echo " (*) Flush privileges ... "
mysql -e "FLUSH PRIVILEGES;"

# Set root password
echo " (*) Setting root password ... "
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASSWORD';"

# Save the privileges
mysql -uroot -p${ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

cat /etc/mysql/mariadb.conf.d/50-server.cnf

mysqladmin -uroot -p${ROOT_PASSWORD} shutdown

echo "=> MariaDB database and user were created successfully! "

# exec mysqld