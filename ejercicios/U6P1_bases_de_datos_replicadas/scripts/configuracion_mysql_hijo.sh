#!/bin/bash

# Mostramos los comandos que se ejecutan
set -ex

# Actualizamos el sistema
apt update -y

# Instalamos mysql
apt install mysql-server -y

source .env

# Copiamos el archivo de configuración de mysql por defecto, para luego asegurarme de que los siguientes comandos funcionen
cp ../config/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

# Creamos la base de datos liga (sin datos)
mysql -u root -e "CREATE DATABASE IF NOT EXISTS liga"

# Importamos los valores de la base de datos liga
#mysql -u root liga < /tmp/dump.sql
mysql liga < /tmp/dump.sql

# Cambiamos los valores del archivo mysqld.cnf
sed -i "s/# server-id		= 1/server-id		= 2/" /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i "s:# log_bin			= /var/log/mysql/mysql-bin.log:log_bin			= /var/log/mysql/mysql-bin.log:" /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i "s/# binlog_do_db		= include_database_name/binlog_do_db		= liga/" /etc/mysql/mysql.conf.d/mysqld.cnf
echo "relay-log = /var/log/mysql/mysql-relay-bin.log" >> /etc/mysql/mysql.conf.d/mysqld.cnf

# Reiniciamos el servicio de mysql
systemctl restart mysql

# Cambiamos la configuración de la replicación de mysql
mysql -u root -e "CHANGE REPLICATION SOURCE TO SOURCE_HOST='$IP_MYSQL_PADRE',SOURCE_USER='$usuario',SOURCE_PASSWORD='$password_user_root',SOURCE_LOG_FILE='mysql-bin.000001',SOURCE_LOG_POS=157"

# Arrancamos la replicacion
mysql -u root -e "START REPLICA"

# Mostramos un mensaje de comprobación
mysql -u root -e "SHOW REPLICA STATUS\G" | grep State


