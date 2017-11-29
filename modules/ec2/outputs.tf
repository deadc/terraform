output "ec2_generic_instance" {
  value = "${aws_instance.ec2_generic_instance.id}"
}

output "ec2_generic_instance_ip" {
  value = "${aws_instance.ec2_generic_instance.private_ip}"
}
