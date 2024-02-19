#!/bin/bash

# Mostramos los comandos que se ejecutan
set -ex

# Actualizamos el sistema
apt update -y

# Instalamos mysql
apt install mysql-server -y

source .env

# Modificamos los permisos del usuario root
#mysql -u root <<< "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY '$password_user_root'"

# Creamos la base de datos liga (sin datos)
mysql -u root -p$password_user_root -e "CREATE DATABASE if not exists liga"