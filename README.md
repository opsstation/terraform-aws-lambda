# # 🏗️ Terraform-AWS-Lambda

[![OpsStation](https://img.shields.io/badge/Made%20by-OpsStation-blue?style=flat-square&logo=terraform)](https://www.opsstation.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-1.13%2B-purple.svg?logo=terraform)](#)
[![CI](https://github.com/OpsStation/terraform-aws-ec2/actions/workflows/ci.yml/badge.svg)](https://github.com/OpsStation/terraform-aws-ec2/actions/workflows/ci.yml)

> 🌩️ **A production-grade, reusable AWS Ec2 module by [OpsStation](https://www.opsstation.com)**
> Designed for reliability, performance, and security — following AWS networking best practices.
---


## 🏢 About OpsStation

**OpsStation** delivers **Cloud & DevOps excellence** for modern teams:
- 🚀 **Infrastructure Automation** with Terraform, Ansible & Kubernetes
- 💰 **Cost Optimization** via scaling & right-sizing
- 🛡️ **Security & Compliance** baked into CI/CD pipelines
- ⚙️ **Fully Managed Operations** across AWS, Azure, and GCP

> 💡 Need enterprise-grade DevOps automation?
> 👉 Visit [**www.opsstation.com**](https://www.opsstation.com) or email **hello@opsstation.com**

---
## 🌟 Features

- ✅ Deploys and manages **AWS Lambda functions** using Terraform
- ✅ Supports **ZIP-based**, **Container Image-based**, and **S3-based** Lambda deployments
- ✅ Automatically creates required **IAM Roles & IAM Policies** for Lambda execution
- ✅ Supports **environment variables**, **Lambda Layers**, **DLQ (Dead-Letter Queue)**, and **EFS file-system mounting**
- ✅ Configurable **runtime**, **handler**, **memory size**, **timeout**, **architecture**, and **reserved concurrency**
- ✅ Allows integration with event sources like **API Gateway**, **S3**, **SNS**, **SQS**, **EventBridge**, and **CloudWatch Events**
- ✅ Provides automatic **packaging, versioning**, and **alias creation**
- ✅ Supports VPC configuration with **subnets** and **security groups**
- ✅ Enables tagging and naming through the **Labels module**
- ✅ Follows AWS best practices for **serverless security**, **scalability**, and **reliability**
- ✅ Fully compatible with other **OpsStation Terraform serverless modules**

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
### 🔐 Outputs (AWS Lambda Module)

| Name                     | Description                                                                 |
|---------------------------|-----------------------------------------------------------------------------|
| `lambda_arn`             | The **ARN of the deployed Lambda function**.                                |
| `lambda_name`            | The **name of the Lambda function**.                                        |
| `invoke_arn`             | The **ARN used to invoke the Lambda function** (e.g., via API Gateway).     |
| `role_arn`               | The **IAM execution role ARN** associated with the Lambda function.         |
| `lambda_version`         | The **latest published version** of the Lambda function.                    |
| `lambda_alias_name`      | The **alias name** created for safe deployments (if enabled).               |
| `memory_size`            | The **memory configured** for the Lambda function (in MB).                  |
| `timeout`                | The **execution timeout** configured for the Lambda function (in seconds).  |
| `runtime`                | The **runtime environment** of the Lambda function (Python, Node.js, etc.).|
| `package_type`           | The **deployment package type** (`Zip` or `Image`).                         |
| `vpc_subnet_ids`         | The list of **VPC subnet IDs** assigned to the Lambda (if VPC enabled).     |
| `vpc_security_group_ids` | The list of **security group IDs** attached to the Lambda (if VPC enabled). |
| `environment_variables`  | A map of **environment variables** configured for the Lambda function.      |
| `tags`                   | A mapping of **tags** assigned to all created Lambda resources.             |

---
### ☁️ Tag Normalization Rules (AWS)

| Cloud | Case      | Allowed Characters | Example                            |
|--------|-----------|------------------|------------------------------------|
| **AWS** | TitleCase | Any              | `Name`, `Environment`, `CostCenter` |

---
### 💙 Maintained by [OpsStation](https://www.opsstation.com)
> OpsStation — Simplifying Cloud, Securing Scale.
