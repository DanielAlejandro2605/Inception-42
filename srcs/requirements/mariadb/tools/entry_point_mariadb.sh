#!/bin/bash

# Path to the original SQL script
SQL_SCRIPT="/secure_init_db.sql"

# Run mysqld with the modified SQL script
mysqld --bootstrap --init-file="$SQL_SCRIPT"

# Start MariaDB
service mariadb start
sleep 2

# Create database for wordpress
echo " (*) Creating ${DB_NAME} database ..."
mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Create user for wordpress database
echo " (*) Creating user ${DB_USER_NAME} ... "

# mysql -e "DROP USER IF EXISTS '$WP_USERNAME';"
# mysql -e "FLUSH PRIVILEGES;"
mysql -e "CREATE USER '$DB_USER_NAME'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"


# Grant privileges for wordpress user database to the wordpress database
echo " (*) Grant privileges for ${DB_USER_NAME} on ${DB_NAME} ... "
mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER_NAME'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"

# Save the privileges 
echo " (*) Flush privileges ... "
mysql -e "FLUSH PRIVILEGES;"

# Set root password
echo " (*) Setting root password ... "
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_USER_PASSWORD';"

# Save the privileges
mysql -uroot -p${DB_ROOT_USER_PASSWORD} -e "FLUSH PRIVILEGES;"

mysqladmin -uroot -p${DB_ROOT_USER_PASSWORD} shutdown

echo "=> MariaDB database and user were created successfully! "

# cat /etc/mysql/mariadb.conf.d/50-server.cnf

exec mysqld