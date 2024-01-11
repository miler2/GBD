#!/bin/bash
set -x

echo "*****WARNING*****"
echo "Antes de continuar, debe cambiar la contraseña del directorio 'scripts/.env', si no ha hecho esto, escriba 'n'."
echo "¿Quiere continuar la instalación con la configuración actual?"
read -n 1 respuesta



if [ $respuesta = 's' ]; then
    apt update -y
    #apt upgrade -y

    #Instalamos docker en nuestra máquina
    apt install apt-transport-https ca-certificates curl software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
    apt install docker-ce -y

    #Creamos el docker MySQL con persistencia de datos:
    #Usamos el archivo mysql.sh
    ./scripts/mysql.sh

    #Creamos el docker PhpMyAdmin
    ./scripts/phpmyadmin.sh

    #Hacemos la configuración correspondiente del docker mysql
    ./scripts/mysql_config.sh
elif [ $respuesta = 'n' ]; then
    echo "Adiós!!"
else
    echo "No ha escrito 's' o 'n'. Escriba 'n' si quiere cancelar la instalación."
fi