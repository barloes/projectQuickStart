resource "aws_iam_role" "role" {
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

resource "aws_iam_instance_profile" "profile" {
  role = aws_iam_role.role.name
}

resource "aws_iam_role_policy" "policy" {
  role = aws_iam_role.role.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "allowall",
        "Effect" : "Allow",
        "Action" : [
          "*"
        ],
        "Resource" : "*"
      }
    ]
  })
}

