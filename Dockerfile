FROM debian:buster

LABEL maintainer="bapmarti@student.42.fr"

# Define working directory.
WORKDIR /

COPY ./srcs/ ./root/

# Install for me (dev)
RUN \
  apt-get update && \
	apt-get install -y htop 

# Install Nginx | php-fpm | mariadb-server.
RUN \
  apt-get install -y nginx php-fpm php-mysql wget mariadb-server && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
	rm /etc/nginx/sites-enabled/default && rm /etc/nginx/sites-available/default && \
	cp /root/nginx.conf /etc/nginx/sites-available/localhost && \
	ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

ADD https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-english.tar.gz /tmp
RUN \
	mkdir /var/www/phpmyadmin && \
	tar zxvf /tmp/phpMyAdmin-4.9.1-english.tar.gz -C /var/www/phpmyadmin --strip-components 1 && \
	service mysql start && mysql --execute "CREATE USER 'bapmarti'@'localhost' IDENTIFIED BY 'password';CREATE DATABASE wordpress;GRANT ALL PRIVILEGES ON *.* TO 'bapmarti'@'localhost';FLUSH PRIVILEGES;"

RUN \
	wget https://wordpress.org/latest.tar.gz -P /tmp && \
	mkdir -p /var/www/wordpress && tar xzf /tmp/latest.tar.gz -C /var/www/wordpress --strip-components 1 && \
	cp /root/wp-config.php /var/www/wordpress/ && rm /var/www/wordpress/wp-config-sample.php && \
  chown -R www-data:www-data /var/www && chmod 755 -R /var/www

RUN rm -r /var/www/html && mkdir -p /var/www/localhost && cp /root/index.php /var/www/localhost

CMD bash /root/start.sh && tail -f /dev/null
