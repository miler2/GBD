# Valores globales
variable "region" {
  description = "Región de AWS donde se creará la instancia"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "Nombre de la clave pública"
  type        = string
  default     = "vockey"
}

#Valores globales de instancias
variable "ami_id" {
  description = "Identificador de la AMI"
  type        = string
  default     = "ami-00874d747dde814fa"
}

variable "instance_type" {
  description = "Tipo de instancia"
  type        = string
  default     = "t2.small"
}


#------------------------------------------------------------------------------------
# Grupo de seguridad para las maquinas mysql
variable "nombre_security_group_mysql" {
  description = "Nombre del grupo de seguridad de las maquinas mysql"
  type        = string
  default     = "mysql"
}

variable "descripcion_security_group_mysql" {
  description = "Descripción del grupo de seguridad de las maquinas mysql"
  type        = string
  default     = "Grupo de seguridad para las maquinas mysql"
}

variable "puertos_security_group_mysql" {
  description = "Puertos de entrada del grupo de seguridad de las maquinas mysql"
  type        = list(number)
  default     = [22, 3306]
}

variable "protocolo_seguridad_mysql" {
  description = "Protocolo de seguridad para los puertos de entrada de las maquinas mysql"
  type        = string
  default     = "tcp"
}

#------------------------------------------------------------------------------------
# Instancias
#*********************************************
# Mysql padre
variable "nombre_instancia_mysql_padre" {
  description = "Nombre de la instancia mysql padre"
  type        = string
  default     = "mysql_padre"
}

#*********************************************
# Mysql hijo
variable "nombre_instancia_mysql_hijo" {
  description = "Nombre de la instancia mysql hijo"
  type        = string
  default     = "mysql_hijo"
}