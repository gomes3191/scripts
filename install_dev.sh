#!/bin/sh

#######################################
# Bash script to install an AMP stack and PHPMyAdmin plus tweaks. For Debian based systems.
# Written by @AamnahAkram from http://aamnah.com

# In case of any errors (e.g. MySQL) just re-run the script. Nothing will be re-installed except for the packages with errors.
#######################################

#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

# Update packages and Upgrade system
echo "$Cyan \n Atualizando sistema.. $Color_Off"
sudo apt-get update -y && sudo apt-get upgrade -y

## Instalando o git
sudo apt-get install git

## Install AMP
echo "$Cyan \n Instalando Apache2... $Color_Off"
sudo apt-get install apache2 apache2-doc apache2-utils libexpat1 ssl-cert -y

echo "$Cyan \n Instalando PHP & Dependências... $Color_Off"
sudo apt-get install php php-zip libapache2-mod-php php-common php-curl php-cli php-mbstring php-common php-json php-opcache php-readline php-xml php-dev php-gd php-pear php-imagick php-pgsql php-pspell php-recode php-xsl php-xdebug -y


echo "$Cyan \n Instalando PostgreSQL... $Color_Off"
sudo apt-get install postgresql postgresql-contrib


#echo "$Cyan \n Instalando PHP & Dependências... $Color_Off"
#sudo apt-get install php7.3 libapache2-mod-php php-common php-curl php-cli php-mbstring php-common php-json php7.3-opcache php-readline php7.3-xml php-dev php-gd php-pear dh-php php-imagick php-mysql php-pspell php-recode php-xdebug -y

echo "$Cyan \n Instalando MySQL... $Color_Off"
#sudo apt-get install libmysqlclient-dev mysql-client-5.7 mysql-server-5.7 libhtml-template-perl libaio1 mysql-workbench

# Instala mysql community versão + recente
#sudo apt-get install mysql-community-server mysql-community-client mysql-workbench-community libmysqlclient-dev libhtml-template-perl libaio1


#echo "$Cyan \n Installing phpMyAdmin $Color_Off"
#sudo apt-get install phpmyadmin -y

## TWEAKS and Settings
# Permissions
echo "$Cyan \n Configurando permissão para /var/www $Color_Off"
sudo chown -R www-data:www-data /var/www
echo "$Green \n Permissão configurada com sucesso! $Color_Off"

# Enabling Mod Rewrite, required for WordPress permalinks and .htaccess files
echo "$Cyan \n Ativando Modulos $Color_Off"
sudo a2enmod rewrite
sudo phpenmod mcrypt

# Restart Apache
echo "$Cyan \n Reinicializando apache... $Color_Off"
sudo service apache2 restart
