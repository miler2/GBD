# Configuramos el proveedor de AWS
provider "aws" {
  region = var.region
}

#--------------------------------------------------------------------------------------------------
# Creamos el grupo de seguridad
resource "aws_security_group" "security_group" {
  name        = var.nombre_security_group
  description = var.descripcion_security_group
}

# Creamos las reglas de entrada del grupo de seguridad.
resource "aws_security_group_rule" "ingres" {
  security_group_id = aws_security_group.security_group.id
  type              = "ingress"

  count       = length(var.puertos_security_group)
  from_port   = var.puertos_security_group[count.index]
  to_port     = var.puertos_security_group[count.index]
  protocol    = var.protocolo_seguridad
  cidr_blocks = ["0.0.0.0/0"]
}

# Creamos las reglas de salida del grupo de seguridad.
resource "aws_security_group_rule" "egres" {
  security_group_id = aws_security_group.security_group.id
  type              = "egress"

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

#--------------------------------------------------------------------------------------------------
# Instancias

#******************************************************************************
# Creamos la instancia GBD_U6P1
resource "aws_instance" "GBD_U6P1" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.security_group.name]

  tags = {
    Name = var.nombre_instancia
  }
}

# Creamos una IP elástica y la asociamos
resource "aws_eip" "ip_elastica" {
  instance = aws_instance.GBD_U6P1.id
}


#--------------------------------------------------------------------------------------------------
# Mostramos la IP pública de la máquina
output "elastic_ip" {
  value = aws_eip.ip_elastica.public_ip
}