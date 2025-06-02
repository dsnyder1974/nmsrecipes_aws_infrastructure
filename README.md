# AWS Infrastructure with Terraform

This Terraform project sets up an AWS infrastructure for proving a backend API. The backend is implemented using Lambda functions, which have access to a Postgres database and Secrets Manager. The database is located on a private subnet, so a Bastion host is setup to allow direct access to database management software, such as pgAdmin. The project's progress is tracked in [**Notion**](https://perpetual-cobalt-b4e.notion.site/1f50ea20f0f480339cf7f733b899b07a?v=1f50ea20f0f4814d8434000ca574d7d9&source=copy_link).

## 📁 Project Structure

```
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── api_gateway/
│   ├── rds/
│   ├── networking/
│   └── ...
└── ...
```

## 🚀 Features

- AWS Lambda in private subnets
- RDS (PostgreSQL) with secure VPC access
- IAM roles for Lambda execution and Secrets Manager access
- API Gateway for public endpoints
- Bastion host for secure RDS access

## 🛠 Usage

### Prerequisites

- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
- AWS credentials configured via environment or `~/.aws/credentials`
    - Use `aws configure` or equivalent to set up

### Initialize Terraform

```bash
terraform init
```

### Plan Infrastructure

```bash
terraform plan
```

### Apply Infrastructure

```bash
terraform apply
```

## 🔐 Security Notes

- Secrets are managed via AWS Secrets Manager.
- Ensure `.tfvars` and `.tfstate` files are excluded from version control (`.gitignore` is provided).
