#!/bin/bash

source scripts/.env

docker exec -i mysql bash -c "mysql -u root -p$password_user_root <<< \"ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY '$password_user_root'\""
docker exec -i mysql bash -c "mysql -u root -p$password_user_root <<< \"ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '$password_user_root'\""
