# Terraform AWS EC2 Module

This Terraform module provisions an **AWS EC2 instance** with configurable options and supports **automated configuration** using a script file.

---

## Features

* Launches an EC2 instance with a specified AMI and instance type
* Validates instance type against project requirements
* Supports configuration automation via `terraform_data` provisioners (`file` & `remote-exec`)
* Allows passing custom scripts for post-provisioning setup
* Supports EBS volume size configuration

---

##  Required Inputs

| Name                | Type     | Description                                            |
| ------------------- | -------- | ------------------------------------------------------ |
| `ami_id`            | `string` | ID of the AMI to launch                                |
| `security_group_id` | `string` | Security Group ID to associate with the instance       |
| `project`           | `string` | Project name for tagging and identification            |
| `environment`       | `string` | Environment name (e.g., `dev`, `prod`)                 |
| `component`         | `string` | Component name (e.g., `backend`, `frontend`)           |
| `username`          | `string` | SSH username for connecting to the instance            |
| `password`          | `string` | SSH password for connecting to the instance            |
| `script_file`       | `string` | Path to the script file to be executed on the instance |

---

##  Optional Inputs

| Name            | Type     | Default    | Description                         |
| --------------- | -------- | ---------- | ----------------------------------- |
| `instance_type` | `string` | `t2.micro` | EC2 instance type (validated)       |
| `subnet_id`     | `string` | `null`     | Subnet ID to launch the instance in |
| `volume_size`   | `number` | `20`       | EBS volume size in GB               |
| `iam_instance_profile`   | `string` | `nothing`       | to attach role               |

---

##  Instance Type Validation

```hcl
validation {
  condition     = contains(
    ["t2.micro", "t2.small", "t2.medium", 
     "t3.micro", "t3.small", "t3.medium", 
     "t3a.micro", "t3a.small", "t3a.medium"], 
    var.instance_type
  )
  error_message = "Instance_type must be among 't2/t3/t3a.micro', 't2/t3/t3a.small' or 't2/t3/t3a.medium' as per project requirement"
}
```

---

##  Storage Configuration

```hcl
variable "volume_size" {
  type    = number
  default = 20 # 20GB default
}
```

---

##  Configuration Automation

This module uses **`terraform_data`** with:

* **`file` provisioner** → Uploads your script file to the EC2 instance
* **`remote-exec` provisioner** → Executes the uploaded script

---

##  Example Usage

```hcl
module "backend" {
  source = "git::https://github.com/royal-surnoi/terraform-aws-ec2?ref=main"

  ami_id            = data.aws_ami.custom_ami.id
  instance_type     = var.instance_type
  security_group_id = data.aws_ssm_parameter.allow_all_sg_id.value
  project           = var.project
  environment       = var.environment
  component         = var.component
  username          = var.username
  password          = var.password
  script_file       = var.script_file
}
```

---

##  updates

| Name            | Type     | Default    | Description                         |
| --------------- | -------- | ---------- | ----------------------------------- |
| `iam_instance_profile` | `string` | `t2.micro` | EC2 instance type (validated)       |