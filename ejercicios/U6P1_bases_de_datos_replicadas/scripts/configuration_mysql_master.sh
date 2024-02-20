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

# Modificamos los permisos del usuario root
#mysql -u root <<< "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY '$password_user_root'"

# Creamos un usuario personal '[tu_usuario]'@'%'
mysql -u root -p$password_user_root <<< "DROP USER IF EXISTS '$usuario'@'%'"
mysql -u root -p$password_user_root <<< "CREATE USER '$usuario'@'%' IDENTIFIED WITH mysql_native_password BY '$password_user_root'"
mysql -u root -p$password_user_root <<< "GRANT ALL PRIVILEGES On *.* TO '$usuario'@'%'"

# Creamos la base de datos liga
mysql -u root -p$password_user_root < ../../../bases_de_datos/liga.sql

# Creamos otra base de datos extra (la base de datos que se ignorará)
mysql -u root -p$password_user_root -e "DROP DATABASE IF EXISTS $base_de_datos_no_replica"
mysql -u root -p$password_user_root -e "CREATE DATABASE $base_de_datos_no_replica"

# Cambiamos los valores del archivo mysqld.cnf
#sed -i "s/127.0.0.1/$IP_MYSQL_HIJO/" /etc/mysql/mysql.conf.d/mysqld.cnf        # Este no me funciona con la ip de la máquina, a si que lo dejo en 0.0.0.0
sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i "s/# server-id		= 1/server-id		= 1/" /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i "s:# log_bin                       = /var/log/mysql/mysql-bin.log:log_bin                       = /var/log/mysql/mysql-bin.log:" /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i "s/# binlog_do_db          = include_database_name/binlog_do_db          = liga/" /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i "s/# binlog_ignore_db      = include_database_name/binlog_ignore_db      = $base_de_datos_no_replica/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Reiniamos el servicio de mysql
systemctl restart mysql

# Bloqueamos las tablas de la base de datos
mysql -u root -p$password_user_root -e "FLUSH TABLES WITH READ LOCK"

# Hacemos una copia de seguridad de la base de datos liga
mysqldump -u root -p$password_user_root liga > dump.sql

# Compartimos el archivo dump.sql con el otro ordenador (mysql_hijo)
scp -i labsuser_sad.pem dump.sql ubuntu@$IP_MYSQL_HIJO:/tmp/

# Desbloqueamos las tablas de la base de datos
mysql -u root -p$password_user_root -e "UNLOCK TABLES"