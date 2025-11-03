# AWS App Runner Deployment Guide

## Prerequisites
- AWS Account with appropriate permissions
- GitHub repository: `https://github.com/ABS-IISC/CT_TOOL.git`
- Code pushed to main branch ✅

## Step 1: Access AWS App Runner
1. Login to AWS Console
2. Navigate to **App Runner** service
3. Click **Create service**

## Step 2: Configure Source
1. **Source type**: Repository
2. **Repository**: Connect to GitHub
3. **Repository URL**: `https://github.com/ABS-IISC/CT_TOOL.git`
4. **Branch**: `main`
5. **Deployment trigger**: Automatic (deploys on every push)

## Step 3: Build Settings
1. **Configuration file**: Use configuration file in repository
2. App Runner will automatically detect `apprunner.yaml`

## Step 4: Service Settings
1. **Service name**: `ct-review-tool`
2. **Virtual CPU**: 1 vCPU
3. **Memory**: 2 GB
4. **Port**: 5000 (auto-configured from apprunner.yaml)

## Step 5: Environment Variables (Optional)
Add if using real AWS Bedrock:
- `AWS_ACCESS_KEY_ID`: Your AWS access key
- `AWS_SECRET_ACCESS_KEY`: Your AWS secret key  
- `AWS_DEFAULT_REGION`: us-east-1

## Step 6: Deploy
1. Click **Create & deploy**
2. Wait 5-10 minutes for deployment
3. App Runner will provide a public URL

## Configuration Files Created ✅

### `apprunner.yaml`
```yaml
version: 1.0
runtime: python3
build:
  commands:
    build:
      - pip install -r requirements.txt
run:
  runtime-version: 3.9
  command: python run.py production
  network:
    port: 5000
    env: PORT
  env:
    - name: FLASK_ENV
      value: production
```

### Updated `app.py`
- Added PORT environment variable support
- Production mode configuration
- Automatic debug mode detection

## Post-Deployment
1. Access your app at the provided App Runner URL
2. Test document upload and analysis
3. Verify all functionality works in production

## Monitoring
- App Runner provides built-in logs and metrics
- Monitor application health in AWS Console
- Set up CloudWatch alarms if needed

## Cost Estimation
- **App Runner**: ~$25-50/month for basic usage
- **Data transfer**: Minimal for document processing
- **Storage**: Temporary files only (minimal cost)

## Troubleshooting
- Check App Runner logs for deployment issues
- Verify `requirements.txt` includes all dependencies
- Ensure `apprunner.yaml` syntax is correct
- Test locally with `python run.py production` first