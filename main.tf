terraform {
  cloud {
    organization = "jaware-hashicorp"

    workspaces {
      name = "demo-jenkins-tfe-sentinel-aws"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.28.0"
    }
  }

  required_version = ">= 0.14.0"
}

provider "aws" {
  region = var.region
  profile = var.aws_profile
}


resource "aws_security_group" "tfesentinelaws" {
  name = "tfesentinelaws"
  egress = [
    {
      cidr_blocks      = [ var.aws_allow_cidr_range, ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ var.aws_allow_cidr_range, ]
     description      = "ssh rule"
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  },
  ]
}


resource "aws_instance" "tfesentinelaws" {
  count = 2
  ami = data.aws_ami.ami_os_filter.id
  instance_type = var.aws_instance_type
  #key_name = var.aws_keyname

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 40
  }

  vpc_security_group_ids = [aws_security_group.tfesentinelaws.id]

  tags = var.resource_tags

  volume_tags = var.resource_tags

  depends_on = [aws_security_group.tfesentinelaws]
}

data "aws_ami" "ami_os_filter" {
     most_recent = true

     filter {
        name   = "name"
        values = [var.amifilter_osname]
     }
     filter {
        name = "architecture"
        values = [var.amifilter_osarch]

 }

     filter {
       name   = "virtualization-type"
       values = [var.amifilter_osvirtualizationtype]

 }

     owners = [var.amifilter_owner] 

 }


#output "external_ip" {
#    value = aws_instance.tfesentinelaws.public_ip
#}