provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "dc-terraform"
    key    = "network/vpc"
    region = "us-east-1"
  }
}

module "environment" {
  source = "../../"
}

module "vpc" {
  source = "../../../../modules/vpc"

  vpc_name = "${module.environment.vpc_name}"
  cidr_vpc = "${module.environment.cidr_vpc}"
  region   = "${module.environment.region}"
}
