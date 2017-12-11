variable "app_name" {}
variable "key_pair" {}
variable "vpc_id" {}

variable "instance_type" {
  default = "t2.small"
}

variable "environment" {
  default = "dev"
}

variable "asg_minsize" {
  default = 2
}

variable "asg_maxsize" {
  default = 2
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

variable "default_security_groups" {
  type = "list"
}

variable "backup" {
  default = "yes"
}

variable "lc_public_ip" {
  default = false
}

variable "elb_subnets" {
  type = "list"
}

variable "elb_internal" {
  default = false
}

variable "asg_subnets" {
  type = "list"
}
