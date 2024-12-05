
# AWS S3 Static Website Hosting with Terraform

This project demonstrates how to host a static website using AWS S3 and manage infrastructure as code with Terraform. 
It includes bucket setup, policy management, versioning, replication configurations, error handling, and lifecycle testing. 
The project has been validated with extensive testing and monitoring.

---

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Prerequisites](#prerequisites)
4. [Project Structure](#project-structure)
5. [Setup Instructions](#setup-instructions)
6. [Testing and Validation](#testing-and-validation)
7. [Screenshots](#screenshots)
8. [Test and Sample Files](#test-and-sample-files)
9. [Contributing](#contributing)

---

## Overview
This repository contains code and configurations for:
- Hosting a static website on AWS S3.
- Custom error page setup for unmatched routes.
- Versioning and replication for data protection.
- Automated lifecycle policies and monitoring.
- Infrastructure management with Terraform.

---

## Features
- **Static Website Hosting**: Serve HTML content directly from an S3 bucket.
- **Error Handling**: Custom error page for non-existent resources.
- **Versioning and Replication**: Protect data with versioning and backup replication.
- **Lifecycle Policies**: Automate data transitions and cleanup.
- **Monitoring and Logging**: Detailed logs for activity tracking.
- **Infrastructure as Code**: Automate setup with Terraform.

---

## Prerequisites
- AWS CLI installed and configured. ([AWS CLI Installer](AWSCLIV2.pkg))
- Terraform installed.
- Access to an AWS account with permissions to manage S3 and IAM.
- A code editor like Visual Studio Code.

---

## Project Structure
```plaintext
├── main.tf                       # Terraform configuration for S3 and IAM
├── outputs.tf                    # Terraform outputs
├── variables.tf                  # Terraform variables
├── index.html                    # Main website HTML file
├── error.html                    # Custom error page HTML file
├── AMG.JPG                       # Example image for the website
├── consolidated-aws-commands.md  # AWS CLI and Linux commands
├── commands-with-expected-results.md # Expected results for command tests
├── test-replication.txt          # Test file for S3 replication
├── lifecycle-test.txt            # Test file for lifecycle rules
├── terraform.tfstate             # Terraform state file
├── terraform.tfstate.backup      # Backup Terraform state file
```

---

## Setup Instructions

### Using Terraform
1. **Initialize Terraform**:
   ```bash
   terraform init
   ```
2. **Validate Configuration**:
   ```bash
   terraform validate
   ```
3. **Plan Deployment**:
   ```bash
   terraform plan
   ```
4. **Apply Changes**:
   ```bash
   terraform apply
   ```
5. **Check Terraform State**:
   ```bash
   terraform state list
   ```

### Manually Upload Files
1. Upload `index.html`, `error.html`, `AMG.JPG`, and test files to the S3 bucket:
   ```bash
   aws s3 cp index.html s3://<your-bucket-name>/
   aws s3 cp error.html s3://<your-bucket-name>/
   aws s3 cp AMG.JPG s3://<your-bucket-name>/
   aws s3 cp test-replication.txt s3://<your-bucket-name>/uploads/
   aws s3 cp lifecycle-test.txt s3://<your-bucket-name>/
   ```

### Test the Website
- Open the S3 static website URL in a browser:
  ```
  http://<your-bucket-name>.s3-website-<region>.amazonaws.com
  ```

---

## Testing and Validation
- **Website Validation**:
  - Verify the main page and error page using `curl` commands.
- **S3 Bucket Validation**:
  - List buckets, check policies, and verify replication.
- **IAM Role Validation**:
  - Ensure roles and policies are attached correctly.

See [commands-with-expected-results.md](commands-with-expected-results.md) for detailed tests.

---

## Screenshots
### Main Website
![Main Website](AWS%20S3%20Static%20Website%20Initialization%20and%20Management.png)

### Error Page
![Error Page](AWS%20S3%20Static%20Website%20Hosting%20with%20Custom%20Error%20Pages%20and%20Lifecycle%20Testing.png)

### Object Management
![Object Management](AWS%20S3%20Static%20Website%20Management%20with%20File%20Operations.png)

### Backup and Replication
![Backup and Replication](AWS%20S3%20Static%20Website%20with%20Backup%20Replication%20and%20Advanced%20Management.png)

### Monitoring and Logging
![Monitoring and Logging](AWS%20S3%20Static%20Website%20with%20Logging%20and%20Monitoring.png)

### Lifecycle and Logging
![Lifecycle and Logging](AWS%20S3%20Versioned%20Static%20Website%20with%20Lifecycle%20and%20Logging.png)

---

## Test and Sample Files
- **Test Replication**:
  - Uploaded file: `test-replication.txt`:
    ```
    Replication Test File
    ```
- **Lifecycle Test**:
  - Uploaded file: `lifecycle-test.txt`:
    ```
    Lifecycle Test File
    ```

---

## Contributing
Contributions are welcome! Feel free to submit a pull request or open an issue to discuss improvements.

---


