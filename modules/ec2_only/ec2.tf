

resource "aws_instance" "ec2" {
  count         = var.ec2_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  //user_data                   = file("${path.module}/../../${var.script_path}")
  vpc_security_group_ids      = [var.sg_id]
  associate_public_ip_address = true

  iam_instance_profile = var.profile_name

  credit_specification {
    cpu_credits = "standard"
  }

  tags = {
    Name = var.name
    Node = var.node
  }

  lifecycle {
    ignore_changes = [instance_state]
  }
}

