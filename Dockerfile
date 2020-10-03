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
  	apt-get install -y openssl nginx php7.3-fpm php7.3-mysql wget mariadb-server && \
  	echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
	rm /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default && \
	cp /root/nginx.conf /etc/nginx/sites-available/bapmarti && \
	ln -s /etc/nginx/sites-available/bapmarti /etc/nginx/sites-enabled/bapmarti

# Setup SSL 
RUN \
	cp -r /root/ssl /etc/nginx/ && \
	chmod -R 600 /etc/nginx/ssl

# Remove default website & Install new index
RUN rm -r /var/www/html && mkdir -p /var/www/bapmarti && cp /root/index.php /var/www/bapmarti

# Install phpmyadmin
ADD https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-english.tar.gz /tmp
RUN \
	mkdir /var/www/bapmarti/phpmyadmin && \
	tar zxvf /tmp/phpMyAdmin-4.9.1-english.tar.gz -C /var/www/bapmarti/phpmyadmin --strip-components 1 && \
	service mysql start && mysql --execute "CREATE USER 'bapmarti'@'localhost' IDENTIFIED BY 'password';CREATE DATABASE wordpress;GRANT ALL PRIVILEGES ON *.* TO 'bapmarti'@'localhost';FLUSH PRIVILEGES;"

# Install WordPress
RUN \
	wget https://wordpress.org/latest.tar.gz -P /tmp && \
	mkdir -p /var/www/bapmarti/wordpress && tar xzf /tmp/latest.tar.gz -C /var/www/bapmarti/wordpress --strip-components 1 && \
	cp /root/wp-config.php /var/www/bapmarti/wordpress/ && rm /var/www/bapmarti/wordpress/wp-config-sample.php && \
  	chown -R www-data:www-data /var/www && chmod 755 -R /var/www

CMD bash /root/start.sh && tail -f /dev/null
