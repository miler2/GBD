#!/bin/bash

source scripts/.env

mysql -u root <<< "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY '$password_user_root'"

#Creamos el usuario 'root'@'%'
mysql -u root -p$password_user_root <<< "DROP USER IF EXISTS 'root'@'%'"
mysql -u root -p$password_user_root <<< "CREATE USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '$password_user_root'"
mysql -u root -p$password_user_root <<< "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '$password_user_root'"
mysql -u root -p$password_user_root <<< "GRANT ALL PRIVILEGES On *.* TO 'root'@'%'"

#Creamos el usuario personal '[tu_usuario]'@'%'
mysql -u root -p$password_user_root <<< "DROP USER IF EXISTS '$usuario'@'%'"
mysql -u root -p$password_user_root <<< "CREATE USER '$usuario'@'%' IDENTIFIED WITH mysql_native_password BY '$password_user_root'"
mysql -u root -p$password_user_root <<< "ALTER USER '$usuario'@'%' IDENTIFIED WITH mysql_native_password BY '$password_user_root'"
mysql -u root -p$password_user_root <<< "GRANT ALL PRIVILEGES On *.* TO '$usuario'@'%'"