output "environment" {
  value = "dev"
}

output "region" {
  value = "us-east-1"
}

output "vpc_name" {
  value = "vpc-dev"
}

output "cidr_vpc" {
  value = "10.10.0.0/16"
}

# + EC2 Module

output "key_pair" {
  value = "test"
}

output "default_security_groups" {
  value = []
}

output "availability_zone" {
  value = "us-east-1a"
}
