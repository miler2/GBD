#!/bin/bash

# Mostramos los comandos que se ejecutan
set -ex

# Actualizamos el sistema
apt update -y

# Instalamos mysql
apt install mysql-server -y

source .env

# Modificamos los permisos del usuario root
mysql -u root <<< "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY '$password_user_root'"

# Creamos un usuario personal '[tu_usuario]'@'%'
mysql -u root -p$password_user_root <<< "DROP USER IF EXISTS '$usuario'@'%'"
mysql -u root -p$password_user_root <<< "CREATE USER '$usuario'@'%' IDENTIFIED WITH mysql_native_password BY '$password_user_root'"
mysql -u root -p$password_user_root <<< "GRANT ALL PRIVILEGES On *.* TO '$usuario'@'%'"

# Creamos la base de datos liga, y otra más
mysql -u root -p$password_user_root < ../../../bases_de_datos/liga.sql
mysql -u root -e "CREATE DATABASE base_de_datos_no_replica"

# Copiamos el archivo de configuración de mysql por defecto, para luego asegurarme de que los siguientes comandos funcionen
cp ../config/ /etc/mysql/mysql.conf.d/mysqld.cnf

# Cambiamos los valores del archivo mysqld.cnf
#sed -i "s/127.0.0.1/$MYSQL_PRIVATE_IP/" /etc/mysql/mysql.conf.d/mysqld.cnf