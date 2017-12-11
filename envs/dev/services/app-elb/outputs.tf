output "id" {
  value = "${module.elb.id}"
}

output "name" {
  value = "${module.elb.name}"
}

output "dns_name" {
  value = "${module.elb.dns_name}"
}

output "fqdn" {
  value = "${module.route53.fqdn}"
}
