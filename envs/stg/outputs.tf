output "environment" {
  value = "stg"
}

output "region" {
  value = "us-east-1"
}

output "client_name" {
  value = "cliente-rivendel"
}

output "vpc_name" {
  value = "vpc-stg"
}

output "cidr_vpc" {
  value = "10.20.0.0/16"
}

# + EC2 Module

output "key_pair" {
  value = "dc-labs"
}

output "default_security_groups" {
  value = []
}
