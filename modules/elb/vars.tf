variable "app_name" {}
variable "subnet_id" {}
variable "vpc_id" {}
variable "key_pair" {}

variable "elb_subnets" {
  type = "list"
}

variable "instance_type" {
  default = "t2.small"
}

variable "environment" {
  default = "dev"
}

variable "public_ip" {
  default = false
}

variable "aws_amis" {
  type = "map"

  default = {
    "us-east-1" = "ami-4fffc834"
  }
}

variable "region" {
  default = "us-east-1"
}

variable "backup" {
  default = "yes"
}

variable "number_of_instances" {
  default = 2
}

variable "default_security_groups" {
  type = "list"
}
