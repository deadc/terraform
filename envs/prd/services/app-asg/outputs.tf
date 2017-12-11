output "id" {
  value = "${module.asg.id}"
}

output "name" {
  value = "${module.asg.name}"
}

output "dns_name" {
  value = "${module.asg.dns_name}"
}

output "fqdn" {
  value = "${module.route53.fqdn}"
}
