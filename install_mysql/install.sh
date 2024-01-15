#!/bin/bash

echo ""
echo "--------------------------------------------------------------------------------------------------------------------"
echo "*****WARNING*****"
echo "Antes de continuar, debe cambiar la contraseña del directorio 'scripts/.env', si no ha hecho esto, escriba 'n'."
echo "¿Quiere continuar la instalación con la configuración actual?"
read -n 1 respuesta

if [ $respuesta = 's' ]; then
    #Actualizamos nuestra máquina
    apt update -y

    #Instalamos mysql-server y mysql-client
    apt install mysql-server mysql-client -y

    #Copiamos el archivo de configuración de mysql (por ahora hemos cambiado solo el puerto de mysql)
    cp config/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

    #Hacemos la configuración correspondiente de mysql
    ./scripts/mysql_config.sh
elif [ $respuesta = 'n' ]; then
    echo "Adiós!!"
else
    echo "No ha escrito 's' o 'n'. Escriba 'n' si quiere cancelar la instalación."
fi
