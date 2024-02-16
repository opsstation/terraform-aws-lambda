provider "aws" {
  region = "us-west-2"
}

locals {
  name        = "lambda"
  environment = "test"
}

##-----------------------------------------------------------------------------
## basic lambda Module Call.
##-----------------------------------------------------------------------------
module "lambda" {
  source      = "../../"
  name        = local.name
  environment = local.environment
  filename    = "../../lambda_packages/index.zip" # -- The content of index.py should be present in zip format
  handler     = "index.lambda_handler"
  runtime     = "python3.7"
  variables = {
    foo = "bar"
  }
}
