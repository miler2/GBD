#!/bin/bash

docker stop phpmyadminc
docker run -d --rm --name phpmyadminc --link mysql -e PMA_HOST=mysql -p 8080:80 phpmyadmin
