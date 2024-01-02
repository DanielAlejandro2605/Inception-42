# *** Latest version of bullseye Debian ***
FROM debian:bullseye

# *** Installing MariaDB ***
RUN apt-get update && apt-get install -y mariadb-server

# *** Copy configuration file ***
COPY ./conf/my.cnf /etc/mysql/my.cnf

# *** Copy entrypoint script ***
COPY ./tools/entry_point_mariadb.sh /entry_point_mariadb.sh

# Making the ENTRYPOINT Script executable
RUN chmod +x /entry_point_mariadb.sh

# Expose the default MariaDB port
EXPOSE 3306

# CMD ["mysqld", "service", "start"]
# # Lauch the script after the container is initiated. 
ENTRYPOINT ["/entry_point_mariadb.sh"]


