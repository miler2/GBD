#!/bin/bash
set -x

echo ""
echo "--------------------------------------------------------------------------------------------------------------------"
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

    #Instalamos MySQL
    ./scripts/mysql.sh

    #Hacemos la configuración correspondiente de mysql
    ./scripts/mysql_config.sh
elif [ $respuesta = 'n' ]; then
    echo "Adiós!!"
else
    echo "No ha escrito 's' o 'n'. Escriba 'n' si quiere cancelar la instalación."
fi