#!/bin/bash

source scripts/.env

docker stop mysql
docker run -d --rm -p 3306:3306 --name mysql -v /home/ubuntu/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=$password_user_root mysql
