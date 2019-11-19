FROM debian:buster

LABEL maintainer="bapmarti"

# Install Nginx.
RUN \
  apt-get update && \
  apt-get install -y nginx php-fpm mariadb-server nano && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

ADD https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-english.tar.gz /tmp
RUN \
	mkdir /var/www/pma && \
	tar zxvf /tmp/phpMyAdmin-4.9.1-english.tar.gz -C /var/www/pma --strip-components 1

# Import config
COPY srcs/phpmyadmin.conf /etc/nginx/conf.d/

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /etc/nginx

# Define default command.
CMD ["nginx"l

# Expose ports.
EXPOSE 80
EXPOSE 443
