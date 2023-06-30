set -e

USER=gilbertfrancois
REPO=msx-sdcc-fusion-c
VERSION=400-130

# Create a new builder instance, if not already created
docker buildx create --name msx-docker-builder
docker buildx use msx-docker-builder
docker buildx inspect --bootstrap

docker buildx build --platform=linux/amd64,linux/arm64,linux/arm/v7 \
    --tag ${USER}/${REPO}:${VERSION} \
    --tag ${USER}/${REPO}:latest \
    -f Dockerfile \
    --push \
    .
