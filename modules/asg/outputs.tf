output "id" {
  value = "${aws_elb.generic_elb_web.id}"
}

output "name" {
  value = "${aws_elb.generic_elb_web.name}"
}

output "dns_name" {
  value = "${aws_elb.generic_elb_web.dns_name}"
}
