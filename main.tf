provider "aws" {
  region = "us-east-1"
}

# Main S3 Bucket
resource "aws_s3_bucket" "static_website" {
  bucket = "amg-static-website-12345"
}

# Website Configuration
resource "aws_s3_bucket_website_configuration" "static_website_config" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Public Access Block
resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Bucket Policy
resource "aws_s3_bucket_policy" "static_website_policy" {
  bucket = aws_s3_bucket.static_website.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.static_website.arn}/*"
      }
    ]
  })
}

# Logging Bucket
resource "aws_s3_bucket" "log_bucket" {
  bucket        = "amg-222-logs"
  force_destroy = true
}

# Logging Configuration
resource "aws_s3_bucket_logging" "logging" {
  bucket        = aws_s3_bucket.static_website.id
  target_bucket = aws_s3_bucket.log_bucket.id
  target_prefix = "logs/"
}

# Enable Versioning for Main Bucket
resource "aws_s3_bucket_versioning" "static_website_versioning" {
  bucket = aws_s3_bucket.static_website.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Backup Bucket for Replication
resource "aws_s3_bucket" "backup_bucket" {
  bucket        = "amg-222-backup"
  force_destroy = true
}

# Enable Versioning for Backup Bucket
resource "aws_s3_bucket_versioning" "backup_bucket_versioning" {
  bucket = aws_s3_bucket.backup_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# IAM Role for Replication
resource "aws_iam_role" "replication_role" {
  name = "replication-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "s3.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Replication Configuration
resource "aws_s3_bucket_replication_configuration" "replication" {
  bucket = aws_s3_bucket.static_website.id
  role   = aws_iam_role.replication_role.arn

  depends_on = [
    aws_s3_bucket_versioning.backup_bucket_versioning,
    aws_s3_bucket_versioning.static_website_versioning
  ]

  rule {
    id     = "ReplicationRule"
    status = "Enabled"

    destination {
      bucket        = aws_s3_bucket.backup_bucket.arn
      storage_class = "STANDARD"
    }
  }
}
