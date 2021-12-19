
resource "aws_eip" "eip" {
  instance = aws_instance.ec2.id
  vpc      = true
}


