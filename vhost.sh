#!/bin/bash

        domain=$1
        echo "Creating virtual host $domain"
        echo "... creating virtual host file"

        sudo touch /etc/apache2/sites-available/$domain.conf
        sudo echo "<VirtualHost *:80>" >> /etc/apache2/sites-available/$domain.conf
        sudo echo "ServerName $domain" >> /etc/apache2/sites-available/$domain.conf
        sudo echo "ServerAlias $domain" >> /etc/apache2/sites-available/$domain.conf
        sudo echo "DocumentRoot /var/www/$domain" >> /etc/apache2/sites-available/$domain.conf
        sudo echo "ErrorLog \${APACHE_LOG_DIR}/$domain.error.log" >> /etc/apache2/sites-available/$domain.conf
        sudo echo "CustomLog \${APACHE_LOG_DIR}/$domain.access.log combined" >> /etc/apache2/sites-available/$domain.conf
        sudo echo "</VirtualHost>" >> /etc/apache2/sites-available/$domain.conf

        echo "Virtual host created successfully"

        echo "Creating virtual host directory"
        sudo mkdir /var/www/$domain

        echo "... creating index.html"
        sudo touch /var/www/$domain/index.html
        sudo echo $domain >> /var/www/$domain/index.html

        echo "Virtual host created successfuly"

        echo "Enabling virtual host"
        sudo a2ensite $domain.conf

        echo "Virtual host enabled"

        echo "Reloading apache2 configuration"
        sudo systemctl reload apache2
        echo "Apache2 reloaded successfully"

        exit 0
