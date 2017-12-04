variable "vpc_id" {}

variable "rds_subnet_ids" {
  type = "list"
}

variable "environment" {
  default = "dev"
}

variable "app_name" {
  default = "app"
}

variable "rds_subnet_group_name" {
  default = "vpc-dev"
}

variable "rds_diskspace" {
  default = "10"
}

variable "rds_engine" {
  default = "mysql"
}

variable "rds_mysql_version" {
  default = "5.6.37"
}

variable "rds_instance_type" {
  default = "db.t2.micro"
}

variable "rds_parameter_group" {
  default = "default.mysql5.6"
}

variable "rds_skip_final_snapshot" {
  default = "False"
}

variable "rds_publicly_accessible" {
  default = "False"
}

variable "rds_security_groups" {
  type    = "list"
  default = []
}
