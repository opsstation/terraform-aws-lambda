# Terraform-aws-lambda

# AWS Infrastructure Provisioning with Terraform

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [License](#license)

## Introduction
This module is basically combination of Terraform open source and includes automatation tests and examples. It also helps to create and improve your infrastructure with minimalistic code instead of maintaining the whole infrastructure code yourself.
## Usage
To use this module, you can include it in your Terraform configuration. Here's an example of how to use it:

## Examples

## Example: basic-function

```hcl
module "lambda" {
  source      = "git::https://github.com/opsstation/terraform-aws-lambda.git?ref=v1.0.0"
  name        = local.name
  environment = local.environment
  filename    = "../../lambda_packages/index.zip" # -- The content of index.py should be present in zip format
  handler     = "index.lambda_handler"
  runtime     = "python3.7"
  variables = {
    foo = "bar"
  }
}
```
## Example: basic-s3-function
```hcl
module "lambda" {
  source      = "git::https://github.com/opsstation/terraform-aws-lambda.git?ref=v1.0.0"
  name        = local.name
  environment = local.environment
  s3_bucket   = "bucket-test"
  s3_key      = "index.zip"
  handler     = "index.handler"
  runtime     = "nodejs18.x"
  variables = {
    foo = "bar"
  }
}
```
## Example: complete-function
```hcl
module "lambda" {
  source                            = "git::https://github.com/opsstation/terraform-aws-lambda.git?ref=v1.0.0"
  name                              = local.name
  environment                       = local.environment
  create_layers                     = true
  timeout                           = 60
  filename                          = "../../lambda_packages/index.zip" # -- The content of index.py should be present in zip format
  handler                           = "index.lambda_handler"
  runtime                           = "python3.8"
  compatible_architectures          = ["arm64"]
  cloudwatch_logs_retention_in_days = 7
  reserved_concurrent_executions    = 90
  iam_actions = [
    "logs:CreateLogStream",
    "logs:CreateLogGroup",
    "logs:PutLogEvents"

  ]
  names = [
    "python_layer"
  ]
  layer_filenames = ["../../lambda_packages/layer.zip"] # -- The content of layer.py should be present in zip format
  compatible_runtimes = [
    ["python3.8"]
  ]

  statement_ids = [
    "AllowExecutionFromCloudWatch"
  ]
  actions = [
    "lambda:InvokeFunction"
  ]
  principals = [
    "events.amazonaws.com"
  ]
  source_arns = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/alarm-lambda-role"]
  variables = {
    foo = "bar"
  }
}
```

## Example
For detailed examples on how to use this module, please refer to the '[example](https://github.com/opsstation/terraform-aws-lambda/tree/master/_example)' directory within this repository.

## Author
Your Name Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This project is licensed under the MIT License - see the [LICENSE](https://github.com/opsstation/terraform-aws-lambda/blob/master/LICENSE) file for details.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.22.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.22.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | git::https://github.com/opsstation/terraform-aws-labels.git | v1.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_kms_alias.kms-alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.kms-alias-cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key_policy.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_kms_key_policy.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key_policy) | resource |
| [aws_lambda_function.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_layer_version.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version) | resource |
| [aws_lambda_permission.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_cloudwatch_log_group.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/cloudwatch_log_group) | data source |
| [aws_iam_policy_document.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_actions"></a> [actions](#input\_actions) | The AWS Lambda action you want to allow in this statement. (e.g. lambda:InvokeFunction). | `list(any)` | `[]` | no |
| <a name="input_architectures"></a> [architectures](#input\_architectures) | Instruction set architecture for your Lambda function. Valid values are ["x86\_64"] and ["arm64"]. | `list(string)` | `null` | no |
| <a name="input_assume_role_policy"></a> [assume\_role\_policy](#input\_assume\_role\_policy) | assume role policy document in JSON format | `string` | `"{\n  \"Version\": \"2012-10-17\",\n  \"Statement\": [\n    {\n      \"Action\": \"sts:AssumeRole\",\n      \"Principal\": {\n        \"Service\": \"lambda.amazonaws.com\"\n      },\n      \"Effect\": \"Allow\",\n      \"Sid\": \"\"\n    }\n  ]\n}\n"` | no |
| <a name="input_attach_cloudwatch_logs_policy"></a> [attach\_cloudwatch\_logs\_policy](#input\_attach\_cloudwatch\_logs\_policy) | Controls whether CloudWatch Logs policy should be added to IAM role for Lambda Function | `bool` | `true` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| <a name="input_aws_iam_policy_path"></a> [aws\_iam\_policy\_path](#input\_aws\_iam\_policy\_path) | IAM policy path default value | `string` | `"/"` | no |
| <a name="input_cloudwatch_logs_kms_key_arn"></a> [cloudwatch\_logs\_kms\_key\_arn](#input\_cloudwatch\_logs\_kms\_key\_arn) | The arn for the KMS encryption key for cloudwatch log group | `string` | `null` | no |
| <a name="input_cloudwatch_logs_retention_in_days"></a> [cloudwatch\_logs\_retention\_in\_days](#input\_cloudwatch\_logs\_retention\_in\_days) | Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653. | `number` | `null` | no |
| <a name="input_code_signing_config_arn"></a> [code\_signing\_config\_arn](#input\_code\_signing\_config\_arn) | Amazon Resource Name (ARN) for a Code Signing Configuration | `string` | `null` | no |
| <a name="input_compatible_architectures"></a> [compatible\_architectures](#input\_compatible\_architectures) | List of Architectures lambda layer is compatible with. Currently x86\_64 and arm64 can be specified. | `list(string)` | `null` | no |
| <a name="input_compatible_runtimes"></a> [compatible\_runtimes](#input\_compatible\_runtimes) | A list of Runtimes this layer is compatible with. Up to 5 runtimes can be specified. | `list(any)` | `[]` | no |
| <a name="input_create_iam_role"></a> [create\_iam\_role](#input\_create\_iam\_role) | Flag to control creation of iam role and its related resources. | `bool` | `true` | no |
| <a name="input_create_layers"></a> [create\_layers](#input\_create\_layers) | Flag to control creation of lambda layers. | `bool` | `false` | no |
| <a name="input_dead_letter_target_arn"></a> [dead\_letter\_target\_arn](#input\_dead\_letter\_target\_arn) | The ARN of an SNS topic or SQS queue to notify when an invocation fails. | `string` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of what your Lambda Function does. | `string` | `""` | no |
| <a name="input_descriptions"></a> [descriptions](#input\_descriptions) | Description of what your Lambda Layer does. | `list(any)` | `[]` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | Whether to create lambda function. | `bool` | `true` | no |
| <a name="input_enable_key_rotation"></a> [enable\_key\_rotation](#input\_enable\_key\_rotation) | Specifies whether key rotation is enabled. Defaults to true(security best practice) | `bool` | `true` | no |
| <a name="input_enable_kms"></a> [enable\_kms](#input\_enable\_kms) | Flag to control creation of kms key for lambda encryption | `bool` | `true` | no |
| <a name="input_enable_source_code_hash"></a> [enable\_source\_code\_hash](#input\_enable\_source\_code\_hash) | Whether to ignore changes to the function's source code hash. Set to true if you manage infrastructure and code deployments separately. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_ephemeral_storage_size"></a> [ephemeral\_storage\_size](#input\_ephemeral\_storage\_size) | Amount of ephemeral storage (/tmp) in MB your Lambda Function can use at runtime. Valid value between 512 MB to 10,240 MB (10 GB). | `number` | `512` | no |
| <a name="input_event_source_tokens"></a> [event\_source\_tokens](#input\_event\_source\_tokens) | The Event Source Token to validate. Used with Alexa Skills. | `list(any)` | `[]` | no |
| <a name="input_existing_cloudwatch_log_group"></a> [existing\_cloudwatch\_log\_group](#input\_existing\_cloudwatch\_log\_group) | Whether to use an existing CloudWatch log group or create new | `bool` | `false` | no |
| <a name="input_existing_cloudwatch_log_group_name"></a> [existing\_cloudwatch\_log\_group\_name](#input\_existing\_cloudwatch\_log\_group\_name) | Name of existing cloudwatch log group. | `string` | `null` | no |
| <a name="input_file_system_arn"></a> [file\_system\_arn](#input\_file\_system\_arn) | The Amazon Resource Name (ARN) of the Amazon EFS Access Point that provides access to the file system. | `string` | `null` | no |
| <a name="input_file_system_local_mount_path"></a> [file\_system\_local\_mount\_path](#input\_file\_system\_local\_mount\_path) | The path where the function can access the file system, starting with /mnt/. | `string` | `null` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | The path to the function's deployment package within the local filesystem. If defined, The s3\_-prefixed options cannot be used. | `string` | `null` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | The function entrypoint in your code. | `string` | n/a | yes |
| <a name="input_iam_actions"></a> [iam\_actions](#input\_iam\_actions) | The actions for Iam Role Policy. | `list(any)` | <pre>[<br>  "logs:CreateLogStream",<br>  "logs:CreateLogGroup",<br>  "logs:PutLogEvents"<br>]</pre> | no |
| <a name="input_iam_role_arn"></a> [iam\_role\_arn](#input\_iam\_role\_arn) | Iam Role arn to be attached to lambda function. | `string` | `null` | no |
| <a name="input_image_config_command"></a> [image\_config\_command](#input\_image\_config\_command) | The CMD for the docker image | `list(string)` | `[]` | no |
| <a name="input_image_config_entry_point"></a> [image\_config\_entry\_point](#input\_image\_config\_entry\_point) | The ENTRYPOINT for the docker image | `list(string)` | `[]` | no |
| <a name="input_image_config_working_directory"></a> [image\_config\_working\_directory](#input\_image\_config\_working\_directory) | The working directory for the docker image | `string` | `null` | no |
| <a name="input_image_uri"></a> [image\_uri](#input\_image\_uri) | The ECR image URI containing the function's deployment package. | `string` | `null` | no |
| <a name="input_kms_key_deletion_window"></a> [kms\_key\_deletion\_window](#input\_kms\_key\_deletion\_window) | KMS Key deletion window in days. | `number` | `10` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_lambda_kms_key_arn"></a> [lambda\_kms\_key\_arn](#input\_lambda\_kms\_key\_arn) | The ARN for the KMS encryption key. | `string` | `null` | no |
| <a name="input_layer_filenames"></a> [layer\_filenames](#input\_layer\_filenames) | The path to the function's deployment package within the local filesystem. If defined, The s3\_-prefixed options cannot be used. | `list(any)` | `[]` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function. | `list(string)` | `null` | no |
| <a name="input_license_infos"></a> [license\_infos](#input\_license\_infos) | License info for your Lambda Layer. See License Info. | `list(any)` | `[]` | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | ManagedBy, eg 'opsstation'. | `string` | `"opsstation"` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128. | `number` | `128` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_names"></a> [names](#input\_names) | A unique name for your Lambda Layer. | `list(any)` | `[]` | no |
| <a name="input_package_type"></a> [package\_type](#input\_package\_type) | The Lambda deployment package type. Valid options: Zip or Image | `string` | `"Zip"` | no |
| <a name="input_policy_path"></a> [policy\_path](#input\_policy\_path) | Path of policies to that should be added to IAM role for Lambda Function | `string` | `null` | no |
| <a name="input_principal_org_id"></a> [principal\_org\_id](#input\_principal\_org\_id) | The identifier for your organization in AWS Organizations. Use this to grant permissions to all the AWS accounts under this organization. | `string` | `null` | no |
| <a name="input_principals"></a> [principals](#input\_principals) | The principal who is getting this permission. e.g. s3.amazonaws.com, an AWS account ID, or any valid AWS service principal such as events.amazonaws.com or sns.amazonaws.com. | `list(any)` | `[]` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | Whether to publish creation/change as new Lambda Function Version. Defaults to false. | `bool` | `false` | no |
| <a name="input_qualifiers"></a> [qualifiers](#input\_qualifiers) | Query parameter to specify function version or alias name. The permission will then apply to the specific qualified ARN. e.g. arn:aws:lambda:aws-region:acct-id:function:function-name:2 | `list(any)` | `[]` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `"https://github.com/opsstation/terraform-aws-lambda"` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1. | `number` | `10` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Runtimes. | `string` | `"python3.7"` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | The S3 bucket location containing the function's deployment package. Conflicts with filename. This bucket must reside in the same AWS region where you are creating the Lambda function. | `string` | `null` | no |
| <a name="input_s3_buckets"></a> [s3\_buckets](#input\_s3\_buckets) | The S3 bucket location containing the function's deployment package. Conflicts with filename. This bucket must reside in the same AWS region where you are creating the Lambda function. | `list(any)` | `[]` | no |
| <a name="input_s3_keies"></a> [s3\_keies](#input\_s3\_keies) | The S3 key of an object containing the function's deployment package. Conflicts with filename. | `list(any)` | `[]` | no |
| <a name="input_s3_key"></a> [s3\_key](#input\_s3\_key) | The S3 key of an object containing the function's deployment package. Conflicts with filename. | `string` | `null` | no |
| <a name="input_s3_object_version"></a> [s3\_object\_version](#input\_s3\_object\_version) | The object version containing the function's deployment package. Conflicts with filename. | `string` | `null` | no |
| <a name="input_s3_object_versions"></a> [s3\_object\_versions](#input\_s3\_object\_versions) | The object version containing the function's deployment package. Conflicts with filename. | `list(any)` | `[]` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security group ids for vpc config. | `list(any)` | `[]` | no |
| <a name="input_skip_destroy"></a> [skip\_destroy](#input\_skip\_destroy) | Whether to retain the old version of a previously deployed Lambda Layer. | `bool` | `false` | no |
| <a name="input_snap_start"></a> [snap\_start](#input\_snap\_start) | (Optional) Snap start settings for low-latency startups | `bool` | `false` | no |
| <a name="input_source_accounts"></a> [source\_accounts](#input\_source\_accounts) | This parameter is used for S3 and SES. The AWS account ID (without a hyphen) of the source owner. | `list(any)` | `[]` | no |
| <a name="input_source_arns"></a> [source\_arns](#input\_source\_arns) | When granting Amazon S3 or CloudWatch Events permission to invoke your function, you should specify this field with the Amazon Resource Name (ARN) for the S3 Bucket or CloudWatch Events Rule as its value. This ensures that only events generated from the specified bucket or rule can invoke the function. | `list(any)` | `[]` | no |
| <a name="input_source_file"></a> [source\_file](#input\_source\_file) | Path of source file that is required to be converted in `.zip` file | `string` | `null` | no |
| <a name="input_statement_ids"></a> [statement\_ids](#input\_statement\_ids) | A unique statement identifier. By default generated by Terraform. | `list(any)` | `[]` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet ids for vpc config. | `list(any)` | `[]` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The amount of time your Lambda Function has to run in seconds. Defaults to 3. | `number` | `3` | no |
| <a name="input_tracing_mode"></a> [tracing\_mode](#input\_tracing\_mode) | Tracing mode of the Lambda Function. Valid value can be either PassThrough or Active. | `string` | `null` | no |
| <a name="input_variables"></a> [variables](#input\_variables) | A map that defines environment variables for the Lambda function. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) identifying your Lambda Function. |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | Invoke ARN |
| <a name="output_lambda_log_group_name"></a> [lambda\_log\_group\_name](#output\_lambda\_log\_group\_name) | A mapping of tags to assign to the resource. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Lambda Function |
| <a name="output_tags"></a> [tags](#output\_tags) | A mapping of tags to assign to the resource. |
<!-- END_TF_DOCS -->