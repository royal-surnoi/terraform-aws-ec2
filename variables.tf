variable "ami_id" {
  type    = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
  validation {
    condition     = contains(["t2.micro", "t2.small", "t2.medium", "t3.micro", "t3.small", "t3.medium", "t3a.micro", "t3a.small", "t3a.medium","t2.large","t2.xlarge"], var.instance_type)
    error_message = "Instance_type must be among 't2/t3/t3a.micro', 't2/t3/t3a.small' or 't2/t3/t3a.medium t2.large and xlarge' as per project requirement"
  }
}

variable "security_group_id" {
  type    = string
}

variable "subnet_id" {
  type    = string
  default = ""
}

variable "project" {
  type    = string
}

variable "environment" {
  type    = string
}

variable "component" {
  type    = string
}

variable "ec2_tags" {
  type = map(any)
  default = {
  }
}

variable "common_tags" {
  type    = map(any)
  default = {}
}

variable "volume_size" {
  type    = number
  default = 20 #20GB default
}

variable "username" {
  type    = string
}

variable "password" {
  type    = string
}

variable "script_file" {
  description = "Relative path to shell script file to copy"
  type        = string
}

variable "iam_instance_profile" {
  type = string
  default = ""
}