# Configuramos el proveedor de AWS
provider "aws" {
  region = var.region
}

#--------------------------------------------------------------------------------------------------
# Creamos el grupo de seguridad para las dos maquinas mysql
resource "aws_security_group" "security_group_mysql" {
  name        = var.nombre_security_group_mysql
  description = var.descripcion_security_group_mysql
}

# Creamos las reglas de entrada del grupo de seguridad para mysql.
resource "aws_security_group_rule" "ingres" {
  security_group_id = aws_security_group.security_group_mysql.id
  type              = "ingress"

  count       = length(var.puertos_security_group_mysql)
  from_port   = var.puertos_security_group_mysql[count.index]
  to_port     = var.puertos_security_group_mysql[count.index]
  protocol    = var.protocolo_seguridad_mysql
  cidr_blocks = ["0.0.0.0/0"]
}

# Creamos las reglas de salida del grupo de seguridad para mysql.
resource "aws_security_group_rule" "egres" {
  security_group_id = aws_security_group.security_group_mysql.id
  type              = "egress"

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

#--------------------------------------------------------------------------------------------------
# Instancias

#******************************************************************************
# Creamos la instancia mysql padre
resource "aws_instance" "instancia_mysql_padre" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.security_group_mysql.name]

  tags = {
    Name = var.nombre_instancia_mysql_padre
  }
}

# Creamos una IP elástica y la asociamos
resource "aws_eip" "ip_elastica_mysql_padre" {
  instance = aws_instance.instancia_mysql_padre.id
}

#******************************************************************************
# Creamos la instancia mysql hijo
resource "aws_instance" "instancia_mysql_hijo" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.security_group_mysql.name]

  tags = {
    Name = var.nombre_instancia_mysql_hijo
  }
}

# Creamos una IP elástica y la asociamos
resource "aws_eip" "ip_elastica_mysql_hijo" {
  instance = aws_instance.instancia_mysql_hijo.id
}


#--------------------------------------------------------------------------------------------------
# Mostramos la IP pública de la máquina mysql padre
output "elastic_ip_mysql_padre" {
  value = aws_eip.ip_elastica_mysql_padre.public_ip
}

# Mostramos la IP pública de la máquina mysql hijo
output "elastic_ip_mysql_hijo" {
  value = aws_eip.ip_elastica_mysql_hijo.public_ip
}