
# AWS S3 Bucket and Terraform Project Validation

## Table of Contents
1. [Verify S3 Buckets](#verify-s3-buckets)
2. [Test Static Website Hosting](#test-static-website-hosting)
3. [Validate Bucket Policies](#validate-bucket-policies)
4. [Verify Logging](#verify-logging)
5. [Validate Versioning](#validate-versioning)
6. [Test Replication](#test-replication)
7. [Validate IAM Role](#validate-iam-role)
8. [Terraform Validation](#terraform-validation)
9. [Test Lifecycle Policies](#test-lifecycle-policies)
10. [Browser Validation](#browser-validation)

---

## 1. Verify S3 Buckets

### List All Buckets
```bash
aws s3 ls
```
**Expected Result:**
```
2024-12-02 18:27:13 amg-222-backup
2024-12-02 18:22:47 amg-222-logs
2024-12-02 18:29:24 amg-static-website-12345
```

### Check the Main Bucket
```bash
aws s3 ls s3://amg-static-website-12345/
```
**Expected Result:**
```
2024-12-02 19:50:59     595857 AMG.JPG
2024-12-02 19:50:39        155 error.html
2024-12-02 19:50:30        520 index.html
```

### Check the Logging Bucket
```bash
aws s3 ls s3://amg-222-logs/
```
**Expected Result:**
```
2024-12-02 20:20:10        155 error.html.log
```

### Check the Backup Bucket
```bash
aws s3 ls s3://amg-222-backup/
```
**Expected Result:**
```
2024-12-02 19:56:33     595857 AMG.JPG
2024-12-02 19:56:12        155 error.html
2024-12-02 19:55:48        520 index.html
```

---

## 2. Test Static Website Hosting

### Test the Website URL
```bash
curl http://amg-static-website-12345.s3-website-us-east-1.amazonaws.com
```
**Expected Result:**
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello World HTML</title>
</head>
<body>
    <h1>Hello, Welcome to My Static Website</h1>
    <p>This is a simple HTML file. If you see this message then S3 web hosting is working</p>
    <img src="images/AMG.JPG" alt="Your Image Description">
</body>
</html>
```

### Test Nonexistent File (Error Page)
```bash
curl http://amg-static-website-12345.s3-website-us-east-1.amazonaws.com/nonexistent.html
```
**Expected Result:**
Displays the contents of `error.html`.

---

## 3. Validate Bucket Policies

### Get the Bucket Policy
```bash
aws s3api get-bucket-policy --bucket amg-static-website-12345
```
**Expected Result:**
```json
{
    "Policy": "{"Version":"2012-10-17","Statement":[{"Effect":"Allow","Principal":"*","Action":"s3:GetObject","Resource":"arn:aws:s3:::amg-static-website-12345/*"}]}"
}
```

### Check Public Access Block Settings
```bash
aws s3api get-public-access-block --bucket amg-static-website-12345
```
**Expected Result:**
```json
{
    "PublicAccessBlockConfiguration": {
        "BlockPublicAcls": false,
        "IgnorePublicAcls": false,
        "BlockPublicPolicy": false,
        "RestrictPublicBuckets": false
    }
}
```

---

## 4. Verify Logging

### Check Logs in the Logging Bucket
```bash
aws s3 ls s3://amg-222-logs/
```
**Expected Result:**
```
2024-12-02 20:20:10        155 error.html.log
```

---

## 5. Validate Versioning

### Check Versioning on Main Bucket
```bash
aws s3api get-bucket-versioning --bucket amg-static-website-12345
```
**Expected Result:**
```json
{
    "Status": "Enabled"
}
```

### Check Versioning on Backup Bucket
```bash
aws s3api get-bucket-versioning --bucket amg-222-backup
```
**Expected Result:**
```json
{
    "Status": "Enabled"
}
```

---

## 6. Test Replication

### Upload a Test File to Main Bucket
```bash
echo "Replication Test File" > test-replication.txt
aws s3 cp test-replication.txt s3://amg-static-website-12345/uploads/
```

### Check the File in the Backup Bucket
```bash
aws s3 ls s3://amg-222-backup/uploads/
```
**Expected Result:**
```
2024-12-02 20:00:01        24 test-replication.txt
```

---

## 7. Validate IAM Role

### Check IAM Role
```bash
aws iam get-role --role-name replication-role
```
**Expected Result:**
```json
{
    "Role": {
        "Path": "/",
        "RoleName": "replication-role",
        "Arn": "arn:aws:iam::123456789012:role/replication-role",
        "AssumeRolePolicyDocument": { ... }
    }
}
```

---

## 8. Terraform Validation

### Ensure Terraform State Matches AWS Resources
```bash
terraform state list
```
**Expected Result:**
```
aws_s3_bucket.static_website
aws_s3_bucket_versioning.backup_bucket_versioning
...
```

---

## 9. Test Lifecycle Policies

### Upload a Test File
```bash
echo "Lifecycle Test File" > lifecycle-test.txt
aws s3 cp lifecycle-test.txt s3://amg-static-website-12345/
```

### Check Storage Class After 30 Days (Optional Simulation)
```bash
aws s3api head-object --bucket amg-static-website-12345 --key lifecycle-test.txt
```
**Expected Result:**
```json
{
    "StorageClass": "STANDARD_IA",
    ...
}
```

---

## 10. Browser Validation

### Open Website in Browser
Access the following URL:
```
http://amg-static-website-12345.s3-website-us-east-1.amazonaws.com
```

---

### Notes:
- Replace placeholders like `<website-endpoint>` and `<object-key>` with actual values.
- Regularly monitor storage class transitions for lifecycle policy tests.
