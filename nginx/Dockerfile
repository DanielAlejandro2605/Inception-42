# Latest version of bullseye Debian
FROM debian:bullseye

# Installing nginx
RUN apt-get update && apt-get install -y nginx

# Copy config 
COPY ./conf/default.conf /etc/nginx/conf.d/default.conf

# Config index.html for test
COPY ./tools/index.html /var/www/html/index.html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]