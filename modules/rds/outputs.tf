output "rds_password" {
  value = "${random_string.password.result}"
}

output "rds_username" {
  value = "${aws_db_instance.rds_generic.username}"
}

output "rds_endpoint" {
  value = "${aws_db_instance.rds_generic.endpoint}"
}

output "rds_address" {
  value = "${aws_db_instance.rds_generic.address}"
}
