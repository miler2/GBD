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
#Ejecutamos el mysql.sh, volviendo a crear el docker para unir los dos archivos de configuración con este archivo .sh
./mysql.sh

#Una vez hecho esto usaremos este comando para ver si hemos realizado correctamente los cambios
echo "Aquí vemos si los cambios se han realizado correctamente, tiene que salir 250."
echo "Si sale 150, es que no se ha realizado correctamente"
echo "Ejecuta el siguiente comando desde la consola del docker para verificar los cambios"
echo "sudo docker exec -it mysql bash"
echo "mysql -u root -pMiler -e 'show global variables like "max_connections"';"
#Este comando no me funciona (preguntar en IAW)
#docker exec -i mysql bash < mysql -u root -pMiler -e 'show global variables like "max_connections"';