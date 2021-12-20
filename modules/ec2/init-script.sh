Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"

#!/bin/bash

# sudo yum update -y
# sudo amazon-linux-extras install docker
# sudo yum install docker
# sudo service docker start
# sudo usermod -a -G docker ec2-user

# sudo curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose

bucket_name=junhuibucket
project_name=cicdfyp
aws_acc=642151248908.dkr.ecr.ap-southeast-1.amazonaws.com
ecr_name=junhuiimage

rm -rf /home/ec2-user/*
aws s3 sync s3://$bucket_name/$project_name ./

aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin $aws_acc
docker pull $aws_acc/$ecr_name:cicdfypfe
docker-compose up -d
--//