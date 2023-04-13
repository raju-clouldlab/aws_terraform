#!/bin/bash

# Configure AWS CLI profile
aws configure --profile cloud_user
 
# Initialize Terraform
terraform init

# Plan Terraform changes
terraform plan

# Apply Terraform changes with auto-approval
terraform apply --auto-approve


# add S3 and DynamoDB backend configuration to backend.tf file
cat >> backend.tf << EOF
#To add s3 for remote backend for the terrafrom state file.
terraform {
  backend "s3" {
    bucket          = "statestorebucket123456789"
    key             = "terraform.tfstate"
    dynamodb_table = "state_lock"
    region          = "us-east-1"
  }
}
EOF

#perform aws configure again using aws profile cloud_user
 # Set AWS CLI profile 
export AWS_PROFILE=cloud_user

# Get AWS account ID
aws_account_id=$(aws sts get-caller-identity --query Account --output text)

# This will give the output message on cli with account id to confirm we logged in with correct account
echo "Logged in to AWS account $aws_account_id with profile cloud_user"

# Re-initialize Terraform with backend configuration "terraform init -reconfigure"
terraform init -reconfigure

# Plan Terraform changes
terraform plan

# Apply Terraform changes with auto-approval
terraform apply

# This will give the output message on cli with account id to confirm we logged in with correct account
echo "you logged in to AWS account $aws_account_id with profile cloud_user"

# create keys directory in the home directory if it doesn't exist
mkdir -p ~/keys

# copy the pinky1.pem file to the keys directory
cp pinky1.pem ~/keys/
 







