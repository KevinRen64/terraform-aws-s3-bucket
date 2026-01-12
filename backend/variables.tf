variable "region" {
  type    = string
  default = "ap-southeast-2"
}

variable "backend_bucket_name" {
  type        = string
  description = "Globally-unique S3 bucket name for Terraform state."
}

variable "lock_table_name" {
  type        = string
  description = "DynamoDB table for state locking."
  default     = "terraform-locks"
}

variable "tags" {
  type    = map(string)
  default = {}
}