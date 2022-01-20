module "master_ec2" {
  source = "../ec2_only"

  profile_name  = local.profile_name
  instance_type = local.instance_type
  ami_id        = local.ami_id
  key_name      = local.key_name
  subnet_id     = local.subnet_id
  sg_id         = local.sg_id
  node          = "master"
  name          = "kuber"
  ec2_count     = 0
  script_path   = "tbc"
}

module "worker_ec2" {
  source = "../ec2_only"

  profile_name  = local.profile_name
  instance_type = local.instance_type
  ami_id        = local.ami_id
  key_name      = local.key_name
  subnet_id     = local.subnet_id
  sg_id         = local.sg_id

  node        = "worker"
  name        = "kuber"
  ec2_count   = 0
  script_path = "tbc"
}

locals {
  profile_name  = aws_iam_instance_profile.profile.name
  instance_type = var.instance_type
  ami_id        = var.ami_id
  key_name      = var.key_name
  subnet_id     = aws_subnet.subnet.id
  sg_id         = aws_security_group.main.id
}