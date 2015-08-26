FROM ubuntu:15.04
MAINTAINER michael@cliffom.net

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install apache2 php5-fpm php5-curl supervisor
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/supervisor

COPY DockerConfigs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY DockerConfigs/www.conf /etc/apache2/sites-available/www.conf
RUN a2enmod proxy_fcgi
RUN a2dissite 000-default
RUN a2ensite www

VOLUME ["/var/www/html"]

EXPOSE 80
CMD ["/usr/bin/supervisord"]
