
variable "aws_profile" {
    type = string
    default = ""
}

variable "region" {
  description = "AWS region"
  default     = "us-east-2"
}

variable "aws_allow_cidr_range" {
    type = string
    default = "0.0.0.0/0"
}

variable "aws_instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "c5.4xlarge"
}

variable "amifilter_osname" {
    type = string
    default = "CentOS 7.9*"
}

variable "amifilter_osarch" {
    type = string
    default = "x86_64"
}

variable "amifilter_osvirtualizationtype" {
    type = string
    default = "hvm"
}

variable "amifilter_owner" {
    type = string
    default = "125523088429" # CentOS 7.9
}


variable "resource_tags" {
  description = "Tags to set for all resources"
  type = map(string)
  default = {
    Name = ""
    Owner = ""
    owner = ""
    TTL = ""
  }
}