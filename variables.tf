variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "amg-222"  # Replace with your desired bucket name
}

variable "log_bucket_name" {
  description = "The name of the log bucket"
  type        = string
  default     = "amg-222-logs"  # Replace with your desired log bucket name
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"  # Change if needed (e.g., "us-west-2")
}
