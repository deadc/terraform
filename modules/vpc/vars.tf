variable "vpc_name" {
  default = "dev"
}

variable "cidr_vpc" {
  default = "10.10.0.0/16"
}

variable "azs" {
  default = {
    "us-east-1" = "us-east-1a,us-east-1b,us-east-1c,us-east-1d"
  }
}

variable "region" {
  default = "us-east-1"
}