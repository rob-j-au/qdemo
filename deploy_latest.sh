#!/usr/bin/env bash
set -euo pipefail

# CONFIG — change these for your project
IMAGE_NAME="robjau/qdemo"
CHART_PATH=".cicd/helm/qdemo"
VALUES_FILE="$CHART_PATH/values.yaml"
HELM_IMAGE_PATH=".image.repository"
HELM_TAG_PATH=".image.tag"

# 1️⃣ Build the Docker image
echo "🚀 Building Docker image..."
docker build -t "$IMAGE_NAME:latest" --platform linux/amd64 .

# 2️⃣ Push to registry
echo "📦 Pushing image..."
docker push "$IMAGE_NAME:latest"

# 3️⃣ Get digest from registry
echo "🔍 Getting image digest..."
DIGEST=$(docker inspect --format='{{index .RepoDigests 0}}' "$IMAGE_NAME:latest" | cut -d'@' -f2)

echo "✅ Digest is: $DIGEST"

# 4️⃣ Update values.yaml
echo "✏️ Updating Helm values.yaml..."
yq -i "$HELM_IMAGE_PATH = \"$IMAGE_NAME\"" "$VALUES_FILE"
yq -i "$HELM_TAG_PATH = \"latest@$DIGEST\"" "$VALUES_FILE"

# 5️⃣ Commit and push
echo "📤 Committing and pushing changes..."
git add "$VALUES_FILE"
git commit -m "chore: update image to latest@$DIGEST"
git push

echo "🎉 Done! ArgoCD should sync the new image shortly."