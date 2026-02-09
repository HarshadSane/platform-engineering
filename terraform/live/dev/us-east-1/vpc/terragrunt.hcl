include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  # Load parent configs
  env_config    = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_config = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Explicitly extract locals
  env        = local.env_config.locals.env
  aws_region = local.region_config.locals.aws_region
  tags       = local.env_config.locals.common_tags
}

terraform {
  source = "../../../../modules/vpc"
}

inputs = {
  aws_region = local.aws_region
  env        = local.env
  name       = "dev-vpc"

  cidr = "10.10.0.0/16"

  azs = [
    "${local.aws_region}a",
    "${local.aws_region}b",
    "${local.aws_region}c"
  ]

  public_subnets  = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
  private_subnets = ["10.10.101.0/24", "10.10.102.0/24", "10.10.103.0/24"]

  tags = local.tags
}
