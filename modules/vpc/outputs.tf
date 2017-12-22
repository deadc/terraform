output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "zone_id" {
  value = "${aws_route53_zone.main_zone.zone_id}"
}

output "public_subnets" {
  value = "${join(",",aws_subnet.public_subnet.*.id)}"
}

output "private_subnets" {
  value = "${join(",",aws_subnet.private_subnet.*.id)}"
}

output "vpc_security_group" {
  value = "${aws_security_group.vpc_security_group.id}"
}
