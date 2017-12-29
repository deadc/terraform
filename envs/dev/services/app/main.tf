provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "dev-dc-terraform"
    key    = "services/app"
    region = "us-east-1"
  }
}

module "environment" {
  source = "../../"
}

data "terraform_remote_state" "shared" {
  backend = "s3"

  config {
    bucket = "dev-dc-terraform"
    key    = "network/vpc"
    region = "us-east-1"
  }
}

module "ec2" {
  source                  = "../../../../modules/ec2"
  app_name                = "${var.app_name == "" ?  module.environment.app_name : var.app_name}"
  environment             = "${module.environment.environment}"
  key_pair                = "${data.terraform_remote_state.shared.key_name}"
  subnet_id               = "${element(split(",", "${"${var.attach_eip ? var.attach_eip : var.public_ip}" ? data.terraform_remote_state.shared.public_subnets : data.terraform_remote_state.shared.private_subnets}"), 0)}"
  vpc_id                  = "${data.terraform_remote_state.shared.vpc_id}"
  default_security_groups = ["${module.environment.default_security_groups}", "${data.terraform_remote_state.shared.vpc_security_group}"]
  public_ip               = "${var.public_ip ? var.public_ip : module.environment.public_ip}"
  attach_eip              = "${var.attach_eip ? var.attach_eip : module.environment.attach_eip}"
  allow_ssh               = "${var.allow_ssh}"
}

module "route53" {
  source = "../../../../modules/route53"

  dns_entry   = "${var.app_name == "" ?  module.environment.app_name : var.app_name}"
  environment = "${module.environment.environment}"
  zone_name   = "${module.environment.client_name}"
  zone_id     = "${data.terraform_remote_state.shared.zone_id}"
  ip_address  = "${module.ec2.private_ip}"
}
