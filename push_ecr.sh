
#!/usr/bin/env bash
set -euo pipefail

# Configuration
AWS_REGION="ap-southeast-1"
ECR_REPO="dev-hotel-app"
SOURCE_IMAGE="docker.io/mson14092006/hotel-app:latest"
IMAGE_TAG="${1:-v1}"

# 1. Verify AWS credentials
echo "Checking AWS credentials..."
AWS_ACCOUNT_ID=$(aws sts get-caller-identity \
  --query Account --output text)

# 2. Get ECR repository URI
ECR_URI=$(aws ecr describe-repositories \
  --repository-names "$ECR_REPO" \
  --region "$AWS_REGION" \
  --query 'repositories[0].repositoryUri' \
  --output text)

TARGET_IMAGE="${ECR_URI}:${IMAGE_TAG}"
ECR_REGISTRY="${ECR_URI%/*}"

# 3. Login to AWS ECR
echo "Logging in to ECR..."
aws ecr get-login-password --region "$AWS_REGION" |
  docker login \
    --username AWS \
    --password-stdin "$ECR_REGISTRY"

# 4. Copy image directly from Docker Hub to ECR
echo "Copying image to ECR..."
docker buildx imagetools create \
  --tag "$TARGET_IMAGE" \
  "$SOURCE_IMAGE"

# 5. Verify uploaded image
echo "Verifying image..."
aws ecr describe-images \
  --repository-name "$ECR_REPO" \
  --image-ids imageTag="$IMAGE_TAG" \
  --region "$AWS_REGION" \
  --query 'imageDetails[0].[imageDigest,imageTags]' \
  --output json

echo "Successfully transferred: $TARGET_IMAGE"

