##################################
# Main configuration file for Terraform
##################################
# This file contains the main configuration for the Terraform project.
# It includes the provider configuration and module definitions.
# Database credentials are pulled from AWS Secrets Manager to avoid hardcoding sensitive information.

# tfvars: aws_region, environment_name, my_ip_address, public_key_path

terraform {
  required_version = ">= 1.4.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

# Pull the RDS credentials from AWS Secrets Manager.
data "aws_secretsmanager_secret" "rds_credentials" {
  name = "postgres_credentials"
}

data "aws_secretsmanager_secret_version" "rds_credentials_version" {
  secret_id = data.aws_secretsmanager_secret.rds_credentials.id
}

locals {
  rds_credentials = jsondecode(data.aws_secretsmanager_secret_version.rds_credentials_version.secret_string)
}

# Module definitions

# Networking - Sets up the VPC, subnets, and a public gateway to get to Bastion.
module "networking" {
  source = "./modules/networking"

  environment_name = var.environment_name
}

# Bastion - Sets up a bastion host for SSH access to the private subnets.
module "bastion" {
  source           = "./modules/bastion"
  environment_name = var.environment_name
  public_key_path  = var.public_key_path
  my_ip_address    = var.my_ip_address
  vpc_id           = module.networking.vpc_id
  subnet_id        = module.networking.private_subnet_az1_id
}

# Lambda Security - Sets up security groups and roles for the Lambda functions.
module "lambda_security" {
  source = "./modules/lambda_security"

  environment_name = var.environment_name
  vpc_id           = module.networking.vpc_id
  subnet_ids       = module.networking.private_subnet_ids
}

# RDS - Sets up the PostgreSQL database in AWS RDS.
module "rds" {
  source = "./modules/rds"

  db_username = local.rds_credentials.username
  db_password = local.rds_credentials.password

  environment_name          = var.environment_name
  vpc_id                    = module.networking.vpc_id
  private_subnet_ids        = module.networking.private_subnet_ids
  lambda_security_group_id  = module.lambda_security.lambda_sg_id
  bastion_security_group_id = module.bastion.bastion_security_group_id
}

# Secrets Manager - Sets up AWS Secrets Manager to store sensitive information.
module "secrets_manager" {
  source       = "./modules/secrets_manager"
  vpc_id       = module.networking.vpc_id
  subnet_ids   = module.networking.private_subnet_ids
  lambda_sg_id = module.lambda_security.lambda_sg_id
  aws_region   = var.aws_region
  vpc_cidr     = "10.0.0.0/16"
}

# API Gateway - Sets up the API Gateway for the Lambda functions.
module "api_gateway" {
  source = "./modules/api_gateway"

  environment_name = var.environment_name
}

# Lambda Functions - Sets up the Lambda functions for the application.
#   Uses base_lambda_api to create instances of the lambda functions.

# Resolve latest versions of shared layers
data "aws_lambda_layer_version" "pg_secrets" {
  layer_name = "pg-secrets-lib"
}

data "aws_lambda_layer_version" "with_cors" {
  layer_name = "withCors-lib"
}

locals {
  common_layers = [
    data.aws_lambda_layer_version.pg_secrets.arn,
    data.aws_lambda_layer_version.with_cors.arn,
  ]
}

# List Categories - Lambda function to list data from the Categories table.
module "list_categories" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgListCategories"
  route_key     = "GET /pgCategories"

  layers = local.common_layers

  environment_name          = var.environment_name
  lambda_execution_role_arn = module.lambda_security.lambda_security_role_arn
  lambda_sg_id              = module.lambda_security.lambda_sg_id
  lambda_api_id             = module.api_gateway.lambda_api_id
  lambda_api_execution_arn  = module.api_gateway.lambda_api_execution_arn
  lambda_api_dependency     = module.api_gateway.api_dependency
  subnet_ids                = module.networking.private_subnet_ids
  vpc_id                    = module.networking.vpc_id

  additional_environment_variables = {
    STAGE           = var.environment_name
    ALLOWED_ORIGINS = var.allowed_origins
  }

  db_endpoint = module.rds.rds_endpoint
  db_port     = module.rds.rds_port
}

# Patch Category - Lambda function to patch an existing entry to the Categories table.
module "patch_category" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgPatchCategory"
  route_key     = "PATCH /pgCategory/{id}"

  layers = local.common_layers

  environment_name          = var.environment_name
  lambda_execution_role_arn = module.lambda_security.lambda_security_role_arn
  lambda_sg_id              = module.lambda_security.lambda_sg_id
  lambda_api_id             = module.api_gateway.lambda_api_id
  lambda_api_execution_arn  = module.api_gateway.lambda_api_execution_arn
  lambda_api_dependency     = module.api_gateway.api_dependency
  subnet_ids                = module.networking.private_subnet_ids
  vpc_id                    = module.networking.vpc_id

  additional_environment_variables = {
    STAGE           = var.environment_name
    ALLOWED_ORIGINS = var.allowed_origins
  }

  db_endpoint = module.rds.rds_endpoint
  db_port     = module.rds.rds_port
}

# Post Category - Lambda function to post a new entry to the Categories table.
module "post_category" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgPostCategory"
  route_key     = "POST /pgCategory"

  layers = local.common_layers

  environment_name          = var.environment_name
  lambda_execution_role_arn = module.lambda_security.lambda_security_role_arn
  lambda_sg_id              = module.lambda_security.lambda_sg_id
  lambda_api_id             = module.api_gateway.lambda_api_id
  lambda_api_execution_arn  = module.api_gateway.lambda_api_execution_arn
  lambda_api_dependency     = module.api_gateway.api_dependency
  subnet_ids                = module.networking.private_subnet_ids
  vpc_id                    = module.networking.vpc_id

  additional_environment_variables = {
    STAGE           = var.environment_name
    ALLOWED_ORIGINS = var.allowed_origins
  }

  db_endpoint = module.rds.rds_endpoint
  db_port     = module.rds.rds_port
}

# Delete Category - Lambda function to delete an entry from the Categories table.
module "delete_category" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgDeleteCategory"
  route_key     = "DELETE /pgCategory/{id}"

  layers = local.common_layers

  environment_name          = var.environment_name
  lambda_execution_role_arn = module.lambda_security.lambda_security_role_arn
  lambda_sg_id              = module.lambda_security.lambda_sg_id
  lambda_api_id             = module.api_gateway.lambda_api_id
  lambda_api_execution_arn  = module.api_gateway.lambda_api_execution_arn
  lambda_api_dependency     = module.api_gateway.api_dependency
  subnet_ids                = module.networking.private_subnet_ids
  vpc_id                    = module.networking.vpc_id

  additional_environment_variables = {
    STAGE           = var.environment_name
    ALLOWED_ORIGINS = var.allowed_origins
  }

  db_endpoint = module.rds.rds_endpoint
  db_port     = module.rds.rds_port
}
