terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4"
    }
  }
  backend "s3" {
    bucket       = "bucket-for-oidc-tabish"
    key          = "terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "huma" {
  count             = var.instance-count
  ami               = "ami-0d172033d1c59b91f" # This is pre configured custom AMI
  instance_type     = "t3.micro"
  availability_zone = "us-east-1a"
  # associate_public_ip_address = true

  key_name = "eric2026_windows"
  tags = {
    #   Name = "Huma online store with ALB ${count.index}"
    Name = "Huma online store with ALB ${count.index + 1}"
  }
  root_block_device {

    volume_size = var.disk-size
    volume_type = "gp3"
  }
  user_data = <<-EOF
#!/bin/bash
docker start my-shop || docker run -d -p 80:80 --name my-shop simplcommerce/ci-build
EOF
}

# 
variable "instance-count" {
  description = "variable used to increment ec2 name"
  type        = number
  default     = 2
}

variable "disk-size" {
  description = "to set Hard disk size"
  type        = number
  default     = 31

}



