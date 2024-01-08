# *** Latest version of bullseye Debian ***
FROM debian:bullseye

# *** Installing MariaDB ***
RUN apt-get update && apt-get install -y mariadb-server

# RUN	mkdir -p /run/mysqld && chown -R mysql:root /run/mysqld

# RUN chown -R mysql:mysql /var/lib/mysql

# *** Copy configuration file ***
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# *** Copy entrypoint bash script ***
COPY ./tools/entry_point_mariadb.sh /entry_point_mariadb.sh

# *** Copy sql script that performs the behavior of `mysql_secure_installation` ***
COPY ./tools/secure_init_db.sql /secure_init_db.sql

# Making the ENTRYPOINT Script executable
RUN chmod +x /entry_point_mariadb.sh

# Expose the default MariaDB port
EXPOSE 3306

# Lauch the script after the container is initiated. 
ENTRYPOINT ["/entry_point_mariadb.sh"]


