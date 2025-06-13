# List Items - Lambda function to list data from the Item table.
module "list_items" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgListItems"
  route_key     = "GET /pgItems"

  layers                    = local.common_layers

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


# Patch Item - Lambda function to patch an existing entry to the Item table.
module "patch_item" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgPatchItem"
  route_key     = "PATCH /pgItem/{id}"

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

# Post Item - Lambda function to post a new entry to the Item table.
module "post_item" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgPostItem"
  route_key     = "POST /pgItem"

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

# Delete Item - Lambda function to delete an entry from the Item table.
module "delete_item" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgDeleteItem"
  route_key     = "DELETE /pgItem/{id}"

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
