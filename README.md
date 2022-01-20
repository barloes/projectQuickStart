# Terraform to launch ec2 with docker compose

- github repo to quickly launch new ec2s

# Lint

- terraform fmt -recursive

# Guide

```
terraform init
terraform apply -auto-approve
```

# Log

```
journalctl -u cloud-final
```

#docker-compose up -d -f docker-compose.fe docker-compose.be

change ec2 count here
modules/simpleec2/ec2.tf