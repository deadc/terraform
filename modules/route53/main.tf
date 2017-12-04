resource "aws_route53_record" "dns_entry" {
  zone_id = "${var.zone_id}"
  name    = "${var.dns_entry}.${var.environment}.${var.zone_name}.internal"
  type    = "A"
  ttl     = "30"

  records = ["${var.ip_address}"]
}
