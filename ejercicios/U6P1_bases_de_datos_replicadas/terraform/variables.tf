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
# Grupo de seguridad
variable "nombre_security_group" {
  description = "Nombre del grupo de seguridad de la GBD_U6P1"
  type        = string
  default     = "GBD_U6P1"
}

variable "descripcion_security_group" {
  description = "Descripción del grupo de seguridad de la GBD_U6P1"
  type        = string
  default     = "Grupo de seguridad para la GBD_U6P1"
}

variable "puertos_security_group" {
  description = "Puertos de entrada del grupo de seguridad de la GBD_U6P1"
  type        = list(number)
  default     = [22, 3306]
}

variable "protocolo_seguridad" {
  description = "Protocolo de seguridad para los puertos de entrada de la GBD_U6P1"
  type        = string
  default     = "tcp"
}

#------------------------------------------------------------------------------------
# Instancias
variable "nombre_instancia" {
  description = "Nombre de la instancia"
  type        = string
  default     = "GBD_U6P1"
}