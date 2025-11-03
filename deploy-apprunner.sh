#!/bin/bash
# AWS App Runner deployment script

# Set variables
SERVICE_NAME="ct-review-tool"
REPO_URL="https://github.com/ABS-IISC/CT_TOOL"

# Create App Runner service
aws apprunner create-service \
  --service-name $SERVICE_NAME \
  --source-configuration '{
    "AutoDeploymentsEnabled": true,
    "CodeRepository": {
      "RepositoryUrl": "'$REPO_URL'",
      "SourceCodeVersion": {
        "Type": "BRANCH",
        "Value": "main"
      },
      "CodeConfiguration": {
        "ConfigurationSource": "REPOSITORY"
      }
    }
  }' \
  --instance-configuration '{
    "Cpu": "0.25 vCPU",
    "Memory": "0.5 GB"
  }' \
  --region us-east-1

echo "App Runner service created. Check AWS Console for deployment status."