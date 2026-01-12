variable "region" {
  type        = string
  description = "AWS region to deploy into."
  default     = "ap-southeast-2"
}

variable "bucket_name" {
  type        = string
  description = "Globally-unique S3 bucket name."

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "bucket_name must be 3-63 chars"
  }
}


variable "env" {
  type        = string
  description = "Environment name."
  default     = "dev"

  validation {
    condition     = contains(["dev", "prod"], var.env)
    error_message = "env must be one of: dev, prod."
  }
}

variable "tags" {
  type        = map(string)
  description = "Extra tags to apply to the bucket."
  default     = {}
}

variable "db_password" {
  type      = string
  sensitive = true
  default   = null
}