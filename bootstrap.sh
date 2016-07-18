#! /usr/bin/env bash

###
#
# bootstrap.sh
# Based on https://gist.github.com/rrosiek/8190550
#
###

# Variables
DBPASSWD=W04Abm9lLV0Xl47
IPADDR=$(curl -s http://icanhazip.com)

echo -e "\n--- Updating packages list ---\n"
add-apt-repository -y ppa:ondrej/php
apt-get -qq update

echo -e "\n--- Install base packages ---\n"
apt-get -y install vim curl build-essential python-software-properties git >> /vagrant/vm_build.log 2>&1

echo -e "\n--- Install Apache ---\n"
apt-get install -y apache2

echo -e "\n--- Install MySQL specific packages and settings ---\n"
debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"
apt-get -y install mysql-server >> /vagrant/vm_build.log 2>&1

echo -e "\n--- Installing PHP-specific packages ---\n"
apt-get -y install php7.0 libapache2-mod-php php-curl php-mcrypt php-gd php7.0-mysql php-gettext >> /vagrant/vm_build.log 2>&1

echo -e "\n--- Enabling mod-rewrite ---\n"
a2enmod rewrite >> /vagrant/vm_build.log 2>&1

echo -e "\n--- Allowing Apache override to all ---\n"
sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

echo -e "\n--- Setting document root to public directory ---\n"
rm -rf /var/www
ln -fs /vagrant/code/ /var/www

echo -e "\n--- We definitly need to see the PHP errors, turning them on ---\n"
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/apache2/php.ini
sed -i "s/DirectoryIndex index.html index.cgi index.pl index.php index.xhtml index.htm/DirectoryIndex index.php index.cgi index.pl index.html index.xhtml index.htm/g" /etc/apache2/mods-enabled/dir.conf

echo -e "\n--- Setting up default Virtual Host ---\n"
    echo "<VirtualHost *:80>
        ServerAdmin notifications@filamentlab.com
        ServerName $IPADDR
        DocumentRoot /var/www
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>" >> /etc/apache2/sites-available/workstation.conf
a2ensite workstation.conf

echo -e "\n--- Restarting Apache ---\n"
service apache2 restart >> /vagrant/vm_build.log 2>&1

echo -e "\n--- Installing Composer for PHP package management ---\n"
curl --silent https://getcomposer.org/installer | php >> /vagrant/vm_build.log 2>&1
mv composer.phar /usr/local/bin/composer

echo -e "\n--- Installing NodeJS 6.x and NPM ---\n"
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - >> /vagrant/vm_build.log 2>&1
apt-get -y install nodejs >> /vagrant/vm_build.log 2>&1