#!/bin/bash

# Define the actual root password
ROOT_PASSWORD="12345"

# Path to the original SQL script
SQL_SCRIPT="/secure_init_db.sql"

# Create a temporary file to store modified SQL
TEMP_SQL="/temp_secure_init_db.sql"

# Replace placeholder with actual password in the SQL script
sed "s/{{ROOT_PASSWORD}}/$ROOT_PASSWORD/g" "$SQL_SCRIPT" > "$TEMP_SQL"


# # Run mysqld with the modified SQL script
# mysqld --bootstrap --init-file="$TEMP_SQL"


mysqld --bootstrap --init-file="$TEMP_SQL"
rm "$TEMP_SQL"

echo "Starting MariaDB service..."

# Start MariaDB service
service mariadb start


# Wait for MariaDB service to start (optional)
# This sleep command gives some time for MariaDB to start, adjust as needed
sleep 10

mysql -u root -p"12345" -e "SHOW DATABASES;"

# cat /etc/mysql/my.cnf
