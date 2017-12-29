output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "zone_id" {
  value = "${module.vpc.zone_id}"
}

output "private_subnets" {
  value = "${module.vpc.private_subnets}"
}

output "public_subnets" {
  value = "${module.vpc.public_subnets}"
}

output "vpc_security_group" {
  value = "${module.vpc.vpc_security_group}"
}

output "private_key_pem" {
  value = "${module.keypair.private_key_pem}"
}

output "public_key_openssh" {
  value = "${module.keypair.public_key_openssh}"
}

output "key_name" {
  value = "${module.keypair.key_name}"
}
