#!/bin/bash
set -x

mkdir -p /root/docker/mysql/conf.d

#Creamos el archivo my-custom.cnf dentro del docker
> /root/docker/mysql/conf.d/my-custom.cnf

#Copiamos nuestro archivo local al docker para hacerle la configuración.
cp my-custom.cnf /root/docker/mysql/conf.d/my-custom.cnf

#Eliminamos el docker y lo ejecutamos de nuevo.
docker stop mysql
docker rm mysql
#Ejecutamos el mysql.sh, volviendo a crear el docker para unir los dos archivos de configuración usando este archivo .sh
./mysql.sh


#Creamos el archivo "querys.log" en disco y le damos los permisos adecuados:
touch /var/log/querys.log
chown mysql:mysql /var/log/querys.log

#Ejecutamos una sentencia en mysql 
docker exec -i mysql bash < ejecutable_mysql.sh