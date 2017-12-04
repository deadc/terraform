resource "random_string" "password" {
  length  = 16
  special = true
}

# adicionar mais parameters group.
resource "aws_db_parameter_group" "mysql56_pg" {
  name   = "pg-${var.environment}-${var.app_name}-mysql56"
  family = "mysql5.6"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

resource "aws_db_subnet_group" "generic_sgn" {
  name       = "sgn-${var.environment}-${var.app_name}"
  subnet_ids = ["${var.rds_subnet_ids}"]

  tags {
    Name = "sgn-${var.environment}-${var.app_name}"
  }
}

resource "aws_security_group" "rds_security_group" {
  name   = "aws-${var.environment}-${var.app_name}-rds-sg"
  vpc_id = "${var.vpc_id}"
}

resource "aws_db_instance" "rds_generic" {
  allocated_storage         = "${var.rds_diskspace}"
  storage_type              = "gp2"
  engine                    = "${var.rds_engine}"
  engine_version            = "${var.rds_mysql_version}"
  instance_class            = "${var.rds_instance_type}"
  name                      = "${var.app_name}"
  identifier                = "${var.environment}-${var.app_name}-db"
  username                  = "admin"
  password                  = "${random_string.password.result}"
  multi_az                  = "True"
  db_subnet_group_name      = "${aws_db_subnet_group.generic_sgn.id}"
  parameter_group_name      = "${aws_db_parameter_group.mysql56_pg.name}"
  skip_final_snapshot       = "${var.rds_skip_final_snapshot}"
  publicly_accessible       = "${var.rds_publicly_accessible}"
  final_snapshot_identifier = "${var.app_name}-final-snapshot-${md5(timestamp())}"

  vpc_security_group_ids = [
    "${aws_security_group.rds_security_group.id}",
    "${var.rds_security_groups}",
  ]
}
