#!/bin/bash

echo "MySQL secure installation..."

# Start MariaDB service
service mariadb start

# Wait for MariaDB service to start (optional)
# This sleep command gives some time for MariaDB to start, adjust as needed
sleep 10

echo -e "1234\nn\ny\ny\ny\n" | mysql_secure_installation

mysql -u root -p"1234" -e "
        SHOW TABLES;\"
