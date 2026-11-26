#!/bin/bash

# Mostramos los comandos y detenemos el script si hay algún error
set -ex

# Cargamos las variables del archivo .env
source .env

# Actualizamos la lista de paquetes apt update
apt update
# Instalamos Apache, MySQL, PHP y sus extensiones
apt install -y apache2 mysql-server php libapache2-mod-php php-mysql php-xml php-mbstring php-curl php-zip php-gd php-intl

# Copiamos nuestra configuración de Apache
cp ../conf/000-default.conf /etc/apache2/sites-available/000-default.conf

# Activamos el módulo rewrite
a2enmod rewrite

# Eliminamos la página de bienvenida de Apache si existe
rm -f /var/www/html/index.html

# Comprobamos que la configuración de Apache es correcta
apache2ctl configtest

# Reiniciamos Apache para aplicar los cambios
systemctl restart apache2
