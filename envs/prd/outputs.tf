output "environment" {
  value = "prd"
}

output "region" {
  value = "us-east-1"
}

output "vpc_name" {
  value = "vpc-prd"
}

output "cidr_vpc" {
  value = "10.30.0.0/16"
}

# + EC2 Module

output "key_pair" {
  value = "test"
}

output "default_security_groups" {
  value = []
}

