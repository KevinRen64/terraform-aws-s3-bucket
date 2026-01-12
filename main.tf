provider "aws" {
  region = var.region
}

locals {
  common_tags = merge(
    {
      Environment = var.env
      ManagedBy   = "Terraform"
      Project     = "tf-s3-bucket"
    },
    var.tags
  )
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  tags   = local.common_tags
}

# Public access blocking 
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

# Default encryption (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Version control dev/provider
resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.env == "prod" ? "Enabled" : "Suspended"
  }
}

# Lifecycle policy: retain more historical versions in prod
resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "expire-noncurrent-versions"
    status = "Enabled"

    filter {}

    noncurrent_version_expiration {
      noncurrent_days = var.env == "prod" ? 90 : 14
    }
  }

  depends_on = [aws_s3_bucket_versioning.this]
}