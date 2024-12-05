output "s3_bucket_url" {
  value = aws_s3_bucket.static_website.bucket_regional_domain_name
}
