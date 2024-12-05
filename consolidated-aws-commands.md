
# Complete Guide: AWS S3 Static Website Hosting Project

This guide consolidates all necessary commands and steps for setting up and managing an AWS S3 static website hosting project, including Terraform configurations, AWS CLI commands, and Linux commands.

---

## **1. Terraform Commands**

### Initialize Terraform
```bash
terraform init
```

### Validate the Configuration
```bash
terraform validate
```

### Plan the Deployment
```bash
terraform plan
```

### Apply the Configuration
```bash
terraform apply
```

### Check Terraform State
```bash
terraform state list
```

### Destroy Resources
```bash
terraform destroy
```

---

## **2. AWS CLI Commands**

### S3 Operations

#### List All Buckets
```bash
aws s3 ls
```

#### Upload Files to S3
```bash
aws s3 cp index.html s3://amg-static-website-12345/
aws s3 cp error.html s3://amg-static-website-12345/
aws s3 cp /path/to/image.png s3://amg-static-website-12345/
```

#### List Files in a Bucket
```bash
aws s3 ls s3://amg-static-website-12345/
```

#### Check Bucket Policy
```bash
aws s3api get-bucket-policy --bucket amg-static-website-12345
```

#### Set Bucket Policy
```bash
aws s3api put-bucket-policy --bucket amg-static-website-12345 --policy file://bucket-policy.json
```

#### Check Website Configuration
```bash
aws s3api get-bucket-website --bucket amg-static-website-12345
```

#### Enable Versioning
```bash
aws s3api put-bucket-versioning --bucket amg-static-website-12345 --versioning-configuration Status=Enabled
aws s3api put-bucket-versioning --bucket amg-222-backup --versioning-configuration Status=Enabled
```

#### Check Versioning
```bash
aws s3api get-bucket-versioning --bucket amg-static-website-12345
aws s3api get-bucket-versioning --bucket amg-222-backup
```

#### Test Replication
```bash
echo "Test replication file" > test-replication.txt
aws s3 cp test-replication.txt s3://amg-static-website-12345/uploads/
aws s3 ls s3://amg-222-backup/uploads/
```

#### Check Logs
```bash
aws s3 ls s3://amg-222-logs/
```

---

### IAM Operations

#### Attach IAM Policy for User or Role
```bash
aws iam put-role-policy --role-name replication-role --policy-name ReplicationPolicy --policy-document file://replication-policy.json
```

#### Check IAM Role
```bash
aws iam get-role --role-name replication-role
```

---

## **3. Linux Commands**

### View Directory Contents
```bash
ls
```

### Create and Edit Files
```bash
nano index.html
vi bucket-policy.json
```

### Verify File Content
```bash
cat index.html
cat bucket-policy.json
```

---

## **4. Testing Commands**

### Website Tests

#### Test Website Using `curl`
```bash
curl http://amg-static-website-12345.s3-website-us-east-1.amazonaws.com
```

#### Test Nonexistent File (Error Page)
```bash
curl http://amg-static-website-12345.s3-website-us-east-1.amazonaws.com/nonexistent.html
```

#### Test Direct Image Access
```bash
curl http://amg-static-website-12345.s3-website-us-east-1.amazonaws.com/image.png
```

### Permissions

#### Check File Permissions
```bash
aws s3api head-object --bucket amg-static-website-12345 --key image.png
```

---

### Notes:
- Replace placeholders like `<bucket-name>` or `<file-path>` with actual values.
- Ensure all policies and roles are properly configured before testing.
