#!/bin/bash

#Actualizamos nuestra máquina
apt update -y

#Instalamos mysql-server y mysql-client
apt install mysql-server mysql-client -y

#Copiamos el archivo de configuración de mysql (por ahora hemos cambiado solo el puerto de mysql)
cp config/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

#Hacemos la configuración correspondiente de mysql
./scripts/mysql_config.sh