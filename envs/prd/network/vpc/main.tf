provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "prd-dc-terraform"
    key    = "network/vpc"
    region = "us-east-1"
  }
}

module "environment" {
  source = "../../"
}

module "vpc" {
  source = "../../../../modules/vpc"

  zone_name   = "${module.environment.client_name}"
  vpc_name    = "${module.environment.vpc_name}"
  environment = "${module.environment.environment}"
  cidr_vpc    = "${module.environment.cidr_vpc}"
  region      = "${module.environment.region}"
}
