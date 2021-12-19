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
  ami_id            = "ami-0dc5785603ad4ff54"
  name              = "cicdfyp"
  key_name          = "cicd"
  vpc_cidr          = "10.0.0.0/16"
  availability_zone = "ap-southeast-1a"
  bucket_name       = "junhuibucket"
}

module "shared" {
  source = "./modules/shared"

  bucket_name = "junhuibucket"
}
