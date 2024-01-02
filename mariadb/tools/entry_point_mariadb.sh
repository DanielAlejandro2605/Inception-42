#!/bin/bash

# Start MariaDB
service mariadb start

# Remove anonymous users
mysql -u root -p -e "DELETE FROM mysql.user WHERE User='';"

# Disallow root login remotely
mysql -u root -p -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"

# Remove test database
mysql -u root -p -e "DROP DATABASE IF EXISTS test;"

# Remove privileges related to the test database
mysql -u root -p -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';"

mysql -u root -p -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '089765';"

mysqladmin -u root -p'089765' shutdown

exec mysqld_safe
