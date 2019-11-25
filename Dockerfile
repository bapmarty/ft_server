FROM debian:buster

MAINTAINER bapmarti

# Define working directory.
WORKDIR /

COPY ./srcs/install.sh /
COPY ./srcs/index.php /
COPY ./srcs/nginx.conf /

# Install for me (dev)
RUN \
  apt-get update && \
	apt-get install -y vim htop 

# Install Nginx | php-fpm | mariadb-server.
RUN \
  apt-get install -y nginx php-fpm php-mysql mariadb-server && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
	rm /etc/nginx/sites-enabled/default && rm /etc/nginx/sites-available/default && \
	cp /nginx.conf /etc/nginx/sites-available/localhost && \
	ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/ && \
  chown -R www-data:www-data /var/www && chmod 755 -R /var/www

ADD https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-english.tar.gz /tmp
RUN \
	mkdir /var/www/phpmyadmin && \
	tar zxvf /tmp/phpMyAdmin-4.9.1-english.tar.gz -C /var/www/phpmyadmin --strip-components 1 && \
  chown -R www-data:www-data /var/www/phpmyadmin && chmod 755 -R /var/www/phpmyadmin && \
	service mysql start && mysql --execute "CREATE USER 'bapmarti'@'localhost' IDENTIFIED BY 'password';GRANT ALL PRIVILEGES ON *.* TO 'bapmarti'@'localhost';FLUSH PRIVILEGES;"	

RUN rm -r /var/www/html && mkdir -p /var/www/localhost && cp /index.php /var/www/localhost

CMD bash ./install.sh && tail -f /dev/null
