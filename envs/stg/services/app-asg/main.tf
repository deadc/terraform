provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "stg-dc-terraform"
    key    = "services/app-asg"
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

module "asg" {
  source                  = "../../../../modules/asg"
  app_name                = "appasg"
  environment             = "${module.environment.environment}"
  key_pair                = "${module.environment.key_pair}"
  elb_subnets             = "${split(",", data.terraform_remote_state.shared.public_subnets)}"
  asg_subnets             = "${split(",", data.terraform_remote_state.shared.private_subnets)}"
  vpc_id                  = "${data.terraform_remote_state.shared.vpc_id}"
  default_security_groups = "${module.environment.default_security_groups}"
}
