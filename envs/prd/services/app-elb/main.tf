provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "prd-dc-terraform"
    key    = "services/app-elb"
    region = "us-east-1"
  }
}

module "environment" {
  source = "../../"
}

data "terraform_remote_state" "shared" {
  backend = "s3"

  config {
    bucket = "prd-dc-terraform"
    key    = "network/vpc"
    region = "us-east-1"
  }
}

module "elb" {
  source                  = "../../../../modules/elb"
  app_name                = "appelb"
  environment             = "${module.environment.environment}"
  key_pair                = "${module.environment.key_pair}"
  elb_subnets             = "${split(",", data.terraform_remote_state.shared.public_subnets)}"
  subnet_id               = "${element(split(",", data.terraform_remote_state.shared.private_subnets), 0)}"
  vpc_id                  = "${data.terraform_remote_state.shared.vpc_id}"
  default_security_groups = "${module.environment.default_security_groups}"
}
