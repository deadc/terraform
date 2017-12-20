output "instance_id" {
  value = "${aws_instance.ec2_generic_instance.id}"
}

output "private_ip" {
  value = "${aws_instance.ec2_generic_instance.private_ip}"
}

output "private_dns" {
  value = "${aws_instance.ec2_generic_instance.private_dns}"
}

output "associate_public_ip_address" {
  value = "${aws_instance.ec2_generic_instance.associate_public_ip_address}"
}

output "public_ip" {
  value = "${aws_instance.ec2_generic_instance.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.ec2_generic_instance.public_dns}"
}

output "eip" {
  value = "${join("", aws_eip.instance_eip.*.public_ip)}"
}
