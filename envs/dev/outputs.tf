output "environment" {
  value = "dev"
}

output "app_name" {
  value = "app"
}

output "shared_bucket" {
  value = "dev-dc-terraform"
}

output "public_ip" {
  value = "false"
}

output "attach_eip" {
  value = "false"
}

output "allow_ssh" {
  value = "false"
}

output "region" {
  value = "us-east-1"
}

output "client_name" {
  value = "cliente-rivendel"
}

output "vpc_name" {
  value = "vpc-dev"
}

output "cidr_vpc" {
  value = "10.10.0.0/16"
}

# + EC2 Module

output "key_pair" {
  value = "dc-labs"
}

output "default_security_groups" {
  value = []
}
