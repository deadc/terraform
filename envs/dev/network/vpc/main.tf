provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "dev-dc-terraform"
    key    = "network/vpc"
    region = "us-east-1"
  }
}

module "environment" {
  source = "../../"
}

module "keypair" {
  source = "../../../../modules/keypair"

  client_name = "${var.client_name == "" ?  module.environment.client_name : var.client_name}"
  environment = "${var.environment == "" ?  module.environment.environment : var.environment}"
}

module "vpc" {
  source = "../../../../modules/vpc"

  zone_name   = "${var.client_name == "" ?  module.environment.client_name : var.client_name}"
  vpc_name    = "${module.environment.vpc_name}"
  environment = "${module.environment.environment}"
  cidr_vpc    = "${module.environment.cidr_vpc}"
  region      = "${module.environment.region}"
}
