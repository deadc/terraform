provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "stg-dc-terraform"
    key    = "data/rds"
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
    key    = "network/data"
    region = "us-east-1"
  }
}

module "rds" {
  source              = "../../../../modules/rds"
  app_name            = "app"
  environment         = "${module.environment.environment}"
  vpc_id              = "${data.terraform_remote_state.shared.vpc_id}"
  rds_subnet_ids      = "${split(",", data.terraform_remote_state.shared.private_subnets)}"
  rds_security_groups = "${module.environment.default_security_groups}"
}
