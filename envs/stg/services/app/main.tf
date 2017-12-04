provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "stg-dc-terraform"
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
    bucket = "stg-dc-terraform"
    key    = "network/vpc"
    region = "us-east-1"
  }
}

module "ec2" {
  source                  = "../../../../modules/ec2"
  app_name                = "app"
  environment             = "${module.environment.environment}"
  key_pair                = "${module.environment.key_pair}"
  subnet_id               = "${element(split(",", data.terraform_remote_state.shared.private_subnets), 0)}"
  vpc_id                  = "${data.terraform_remote_state.shared.vpc_id}"
  default_security_groups = "${module.environment.default_security_groups}"
}

module "route53" {
  source = "../../../../modules/route53"

  dns_entry   = "app"
  environment = "${module.environment.environment}"
  zone_name   = "${module.environment.client_name}"
  zone_id     = "${data.terraform_remote_state.shared.zone_id}"
  ip_address  = "${module.ec2.ec2_generic_instance_ip}"
}
