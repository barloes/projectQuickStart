

resource "aws_instance" "ec2" {
  count = var.ec2_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.subnet.id
  user_data              = file("${path.module}/init-script.sh")
  vpc_security_group_ids = [aws_security_group.main.id]

  iam_instance_profile = aws_iam_instance_profile.profile.name

  credit_specification {
    cpu_credits = "standard"
  }

  tags = {
    Name = var.name
  }

  lifecycle {
    ignore_changes = [instance_state]
  }
}

