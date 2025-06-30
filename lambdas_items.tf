# List Items - Lambda function to list data from the Item table.
module "list_items" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgListItems"
  route_key     = "GET /pgItems"

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

# Get Item with Categories - Lambda function to fetch an existing entry in the Item table, along with its associated categories.
module "get_item_with_categories" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgGetItemWithCategories"
  route_key     = "GET /pgGetItemWithCategories/{id}"

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

# Get Ingredients for Item - Lambda function to fetch an ingredient list for an Item.
module "get_ingredients_for_item" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgGetIngredientsForItem"
  route_key     = "GET /pgGetIngredientsForItem/{id}"

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
    REDIS_ENDPOINT  = module.redis.redis_endpoint
  }

  db_endpoint = module.rds.rds_endpoint
  db_port     = module.rds.rds_port
}

# Set Preferred Recipe ID for Item - Lambda function to set the preferred recipe ID for an Item.
module "set_preferred_recipe_for_item" {
  source = "./modules/base_lambda_api"

  function_name = "${var.environment_name}-pgSetPreferredRecipeForItem"
  route_key     = "PATCH /pgSetPreferredRecipeForItem/{id}"

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
    REDIS_ENDPOINT  = module.redis.redis_endpoint
  }

  db_endpoint = module.rds.rds_endpoint
  db_port     = module.rds.rds_port
}
