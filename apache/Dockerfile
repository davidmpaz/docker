FROM debian:jessie

RUN apt-get update && apt-get install -y \
    ca-certificates curl apache2-bin apache2.2-common libapache2-mod-php5 \
    #clean up
    && apt-get remove -y build-essential \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists

ADD files/project.conf /etc/apache2/sites-available/
# Simple startup script to avoid some issues observed with container restart
ADD files/run-apache.sh /run-apache.sh

RUN a2enmod proxy_fcgi mpm_prefork rewrite \
    && a2dismod mpm_event \
    && ln -s /etc/apache2/sites-available/project.conf /etc/apache2/sites-enabled/project.conf \
    && rm /etc/apache2/sites-enabled/*default* \
    && chmod -v +x /run-apache.sh \
    && mkdir /var/www/htdocs \
    && service apache2 restart \
    && usermod -u 1000 www-data

EXPOSE 80 443

CMD ["/run-apache.sh"]