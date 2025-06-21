# Get recipes for an item.
module "get_item_recipes" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgGetItemRecipes"
  route_key     = "GET /pgGetItemRecipes/{id}"

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

# Post recipe for an item.
module "post_recipe" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgPostRecipe"
  route_key     = "POST /pgRecipe"

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

# Patch recipe.
module "patch_recipe" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgPatchRecipe"
  route_key     = "PATCH /pgRecipe/{id}"

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

# Delete recipe.
module "delete_recipe" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgDeleteRecipe"
  route_key     = "DELETE /pgRecipe/{id}"

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
