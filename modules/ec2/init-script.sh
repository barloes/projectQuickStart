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
sudo chmod 666 /var/run/docker.sock

bucket_name=junhuibucket
project_name=cicdfyp
aws_acc=642151248908.dkr.ecr.ap-southeast-1.amazonaws.com
ecr_name=junhuiimage

cd /home/ec2-user
sudo /bin/systemctl stop docker.service
sudo /bin/systemctl start docker.service
sudo rm -rf /home/ec2-user/*
/bin/echo "restart docker service" >> log.txt

aws s3 sync s3://$bucket_name/$project_name ./
/bin/echo "sync s3" >> log.txt
sudo aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin $aws_acc
/bin/echo "ecr auth" >> log.txt
docker pull $aws_acc/$ecr_name:cicdfypfe
/bin/echo "pull image" >> log.txt

docker-compose build && docker-compose up -d
/bin/echo "run image" >> log.txt
--//--