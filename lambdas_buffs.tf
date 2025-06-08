# List Buffs - Lambda function to list data from the Buff table.
module "list_buffs" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgListBuffs"
  route_key     = "GET /pgBuffs"

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


# Patch Buff - Lambda function to patch an existing entry to the Buff table.
module "patch_buff" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgPatchBuff"
  route_key     = "PATCH /pgBuff/{id}"

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

# Post Buff - Lambda function to post a new entry to the Buff table.
module "post_buff" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgPostBuff"
  route_key     = "POST /pgBuff"

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

# Delete Buff - Lambda function to delete an entry from the Buff table.
module "delete_buff" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgDeleteBuff"
  route_key     = "DELETE /pgBuff/{id}"

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
