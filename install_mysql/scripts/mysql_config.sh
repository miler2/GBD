#!/bin/bash

source scripts/.env

sudo mysql -u root <<< "ALTER USER root@localhost IDENTIFIED WITH mysql_native_password BY '$password_user_root'"
sudo mysql -u root <<< "ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '$password_user_root'"
