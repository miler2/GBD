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

# Creamos la base de datos liga (sin datos)
mysql -u root -p$password_user_root -e "CREATE DATABASE if not exists liga"

# Importamos los valores de la base de datos liga
mysql -u root -p$password_user_root liga < /tmp/dump.sql

# Cambiamos los valores del archivo mysqld.cnf
sed -i "s/# server-id		= 1/server-id		= 2/" /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i "s:# log_bin			= /var/log/mysql/mysql-bin.log:log_bin			= /var/log/mysql/mysql-bin.log:" /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i "s/# binlog_do_db		= include_database_name/binlog_do_db		= liga/" /etc/mysql/mysql.conf.d/mysqld.cnf
echo "relay-log = /var/log/mysql/mysql-relay-bin.log" >> /etc/mysql/mysql.conf.d/mysqld.cnf

# Reiniciamos el servicio de mysql
systemctl restart mysql

# Cambiamos la configuración de la replicación de mysql
mysql -u root -e "CHANGE REPLICATION SOURCE TO SOURCE_HOST='master',SOURCE_USER='usuario_replicacion',SOURCE_PASSWORD='contraseña',SOURCE_LOG_FILE='mysql-bin.000001',SOURCE_LOG_POS=157"

