# Instalación de MySQL
Este es el script que me instalará automáticamente lo necesario en la máquina para realizar la creación de mysql server y cliente. Además, nos hace la configuración apropiada de mysql.
- Descomenta y cambia el puerto a 3307.
- Cambia el "bind-address" a 0.0.0.0
- Descomenta "datadir" 

# IMPORTANTE
Antes de ejecutar el script, por favor, modifica la CONTRASEÑA y USUARIO a valores que tú eligas, en el archivo .env dentro de la carpeta scripts.

(La contraseña y usuario por defecto es "hola")

## Indicaciones:
### Instalación
Si es la primera vez usando estos scripts en esta máquina vamos a dar permisos de ejecución a los archivos .sh dentro de la carpeta scripts además del archivo "install.sh".

Para hacer la instalación simplemente ejecuta el archivo install.sh.

**Nota: Tendremos que ejecutar el archivo estando en el directorio "install_mysql"**

### Comprobación de instalación
Si quieres comprobar que se te ha instalado mysql correctamente realiza el siguiente comandos:
- mysql -u root -p[tu_contraseña] <<< "select user, host, plugin from mysql.user"

Este comando nos muestra información sobre los usuarios creados en nuestra base de datos.
