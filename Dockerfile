FROM debian:wheezy

MAINTAINER Darron Froese "darron@froese.org"

RUN apt-get update
RUN apt-get -y install dialog net-tools lynx nano wget
RUN apt-get -y install python-software-properties
RUN add-apt-repository -y ppa:nginx/stable
RUN add-apt-repository -y ppa:ondrej/php5-oldstable
RUN apt-get update

RUN apt-get -y install nginx php5-fpm php5-mysql php-apc php5-imagick php5-imap php5-mcrypt php5-curl curl memcached php5-apcu

RUN wget -O /etc/nginx/sites-available/default https://raw.github.com/talpah/php5-nginx/master/default
RUN echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN mkdir /var/www
RUN echo "<?php phpinfo(); ?>" > /var/www/phpinfo.php
ADD ./index.php /var/www/

EXPOSE 80

CMD service php5-fpm start && nginx
