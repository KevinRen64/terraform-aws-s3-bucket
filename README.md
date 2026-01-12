# Terraform S3 Bucket (tf-s3-bucket)

A production-friendly Terraform project that creates an AWS S3 bucket with:
- Public access blocked
- Default encryption (SSE-S3)
- Conditional versioning (prod enabled, dev suspended)
- Lifecycle policy for noncurrent versions
- Clean variables/outputs structure + examples

## Prerequisites
- Terraform >= 1.6
- AWS credentials configured (recommended: AWS CLI profile or env vars)

## Project Structure
- `versions.tf`: Terraform + provider version constraints
- `main.tf`: resources and logic
- `variables.tf`: inputs + validations
- `outputs.tf`: outputs
- `terraform.tfvars.example`: example values (do not commit secrets)
- `examples/dev`: ready-to-run dev example

## Quick Start (Example: dev)
```bash
terraform init
terraform plan -var-file=examples/dev/terraform.tfvars
terraform apply -var-file=examples/dev/terraform.tfvars
