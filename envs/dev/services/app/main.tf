provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "moip-tf-storage-hmlg"
    key    = "services/app"
    region = "us-east-1"
  }
}

module "environment" {
  source = "../../"
}

module "ec2" {
  source                  = "../../../../modules/ec2"
  app_name                = "app"
  key_pair                = "${module.environment.key_pair}"
  subnet_id               = "${module.environment.subnet_id}"
  vpc_id                  = "${module.environment.vpc_id}"
  availability_zone       = "${module.environment.availability_zone}"
  default_security_groups = "${module.environment.default_security_groups}"
}
