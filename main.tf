locals {

}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-southeast-1"
}

module "ec2" {
  source = "./modules/ec2"

  instance_type     = "t2.micro"
  ami_id            = "ami-026f2ac5256dbee41"
  name              = "cicdfyp"
  key_name          = "cicd"
  vpc_cidr          = "10.0.0.0/16"
  availability_zone = "ap-southeast-1a"
  bucket_name       = "junhuibucket"
}

module "ecr" {
  source = "./modules/ecr"

  ecr_name = "junhuiimage"
}


module "shared" {
  source = "./modules/shared"

  bucket_name = "junhuibucket"
}
