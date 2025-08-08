locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = true
  }
  security_group_ids = [var.security_group_id]
}