output "instance_id" {
  value = "${module.ec2.instance_id}"
}

output "private_ip" {
  value = "${module.ec2.private_ip}"
}

output "private_dns" {
  value = "${module.ec2.private_dns}"
}

output "associate_public_ip_address" {
  value = "${module.ec2.associate_public_ip_address}"
}

output "public_ip" {
  value = "${module.ec2.public_ip}"
}

output "public_dns" {
  value = "${module.ec2.public_dns}"
}

output "eip" {
  value = "${module.ec2.eip}"
}
