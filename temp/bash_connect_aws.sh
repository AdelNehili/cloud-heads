#!/bin/bash

# Step 1: Check AWS CLI Configuration
echo "Checking AWS CLI configuration..."
aws configure list

# Optional Step: Reconfigure AWS CLI
# Uncomment and run if your AWS CLI is not configured correctly.
# aws configure

# Step 2: Manually configure AWS CLI for SSO (if applicable)
# Uncomment and run if you use AWS SSO for authentication.
# aws configure sso

# Step 3: Specify AWS Profile (if using named profiles)
# Replace 'your-profile-name' with your actual profile name
export AWS_PROFILE=your-profile-name

# Check if AWS_PROFILE is correctly set
echo "Using AWS profile: $AWS_PROFILE"

# Step 4: Attempt to create an EKS cluster with eksctl using the specified profile
echo "Attempting to create an Amazon EKS cluster with eksctl..."
eksctl create cluster --profile $AWS_PROFILE

# Note: If the above eksctl command fails due to permissions,
# ensure the IAM role/user associated with the specified profile has the necessary permissions.
# Check IAM role trust relationships and attached policies.

# Step 5: Additional troubleshooting
# If the issue persists, consider reviewing the IAM policies and role trust relationships.
# Ensure your AWS CLI version is up to date by running 'aws --version' and updating if necessary.

