#Docker
Docker files to use for development

#How to

Make reference to this folders from your docker-composer.yml, or use built images from the [hub](https://hub.docker.com)
 
    # data container to persist database data
    db-data:
        image: davidmpaz/mysql-data-container
        # build: mysql-data-container
        
    db:
        container_name: db
        image: mysql:5.6
        expose:
            - 3306
        volumes_from:
            - db-data
        environment:
            # set up values here
            MYSQL_ROOT_PASSWORD: 
            MYSQL_DATABASE:
            MYSQL_USER: db
            MYSQL_PASSWORD:
            
    php:
        container_name: php
        image: davidmpaz/php
        # build: php
        expose:
            - 9000
        links:
            - db
            - mailcatcher
            - "ambassador:localhost.dev"
            - "ambassador:apache"
        volumes:
            # now the source... luke
            - .:/var/www/htdocs
        tty: true
        
    mailcatcher:
        container_name: mailcatcher
        image: schickling/mailcatcher
        ports:
            - 1025:1025
            - 1080:1080
     
    # apache service
    apache:
        container_name: apache
        image: davidmpaz/apache
        # build: apache
        ports:
            - 80:80
            - 443:443
        links:
            - "ambassador:php"
        volumes_from:
            - php
        domainname: localhost.dev
    
    
    # we need to make php and apache visible between each other
    ambassador:
        image: cpuguy83/docker-grand-ambassador
        volumes:
            - "/var/run/docker.sock:/var/run/docker.sock"
        command: "-name php -name apache"
        
Adjust configuration to your needs like domain name, port redirects, etc... and just `docker-compose up -d`.
