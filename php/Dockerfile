FROM debian:jessie

RUN apt-get update && apt-get install -y \
    # php packages
    php5-common php5-cli php5-fpm php5-mcrypt php5-mysql php5-apcu \
    php5-gd php5-imagick php5-curl php5-intl  php5-xdebug php5-xsl \
    # mail support
    ssmtp \
    #clean up
    && apt-get remove -y build-essential \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists

ADD files/pool.conf                                     /etc/php5/fpm/pool.d/
ADD files/xdebug.ini                                    /etc/php5/fpm/conf.d/20-xdebug.ini
ADD files/mailcatcher.ini                               /etc/php5/mods-available/mailcatcher.ini
ADD files/ssmtp.conf                                    /etc/ssmtp/ssmtp.conf

RUN usermod -u 1000 www-data && php5enmod mailcatcher

EXPOSE 9000

CMD ["php5-fpm", "-F"]
