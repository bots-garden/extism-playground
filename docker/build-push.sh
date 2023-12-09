#!/bin/bash
IMAGE_BASE_NAME="gitpod-extism-playground"
IMAGE_TAG="0.0.0"
docker login -u ${DOCKER_USER} -p ${DOCKER_PWD}
docker buildx build \
--build-arg="GO_ARCH=amd64" \
--build-arg="GO_VERSION=1.21.3" \
--build-arg="TINYGO_ARCH=amd64" \
--build-arg="TINYGO_VERSION=0.30.0" \
--build-arg="EXTISM_VERSION=0.3.3" \
--build-arg="EXTISM_ARCH=amd64" \
--build-arg="USER_NAME=gitpod" \
--platform linux/amd64 \
--push -t ${DOCKER_USER}/${IMAGE_BASE_NAME}:${IMAGE_TAG} .
