#!/bin/bash

# Configure AWS CLI profile
aws configure --profile cloud_user

# Initialize Terraform
terraform init

# Plan Terraform changes
terraform plan

# Apply Terraform changes with auto-approval
terraform apply --auto-approve


# add S3 and DynamoDB backend configuration to provider.tf file
cat >> provider.tf << EOF
#To add s3 for remote backend for the terrafrom state file.
terraform {
  backend "s3" {
    bucket          = "statestorebucket12345678917"
    key             = "terraform.tfstate"
    dynamodb_table = "state_lock"
    region          = "us-east-1"
  }
}
EOF

#perform aws configure again
aws configure


# Re-initialize Terraform with backend configuration "terraform init -reconfigure"
terraform init -reconfigure
 
# Plan Terraform changes
terraform plan

# Apply Terraform changes with auto-approval
terraform apply

# create keys directory in the home directory if it doesn't exist
mkdir -p ~/keys

# copy the pinky1.pem file to the keys directory
cp pinky1.pem ~/keys/
 







