locals {
  env = "dev"

  common_tags = {
    Environment = local.env
    Project     = "platform"
    ManagedBy   = "terragrunt"
  }
}
