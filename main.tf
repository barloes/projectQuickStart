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

  instance_type     = "t3.small"
  ami_id            = "ami-0254bf24935da26a5"
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

module "testec2" {
  source = "./modules/simpleec2"

  //manage ec2 num at modules/simpleec2/ec2.tf

  instance_type     = "t4g.small"
  ami_id            = "ami-03d20fc12884694ee"
  key_name          = "cicd"
  vpc_cidr          = "10.0.0.0/16"
  availability_zone = "ap-southeast-1a"
  //script_path       = "initscripts/init_kubectl.sh"
}
