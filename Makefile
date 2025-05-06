# Makefile for building and pushing Docker images for Kali and BlackArch

# Common Variables
VERSION := 1.1.3
DOCKER_USERNAME := erdemozgen
REGISTRY := docker.io

# Docker Buildx builder name
BUILDER_NAME := mybuilder

# Enable Docker BuildKit for building images
export DOCKER_BUILDKIT=1

# BlackArch Image Variables
BLACKCART_IMAGE_NAME := blackcart
BLACKCART_FULL_IMAGE_NAME := $(REGISTRY)/$(DOCKER_USERNAME)/$(BLACKCART_IMAGE_NAME):$(VERSION)
BLACKCART_LATEST_IMAGE_NAME := $(REGISTRY)/$(DOCKER_USERNAME)/$(BLACKCART_IMAGE_NAME):latest

# Kali Image Variables
# Define similar variables for Kali if needed

# Default target
.PHONY: all
all: check-builder build-blackarch push-images

# Check if Buildx builder exists, create if not
.PHONY: check-builder
check-builder:
	@if ! docker buildx ls | grep -q $(BUILDER_NAME); then \
		docker buildx create --name $(BUILDER_NAME) --use; \
	else \
		docker buildx use $(BUILDER_NAME); \
	fi

# BlackArch Image Target
.PHONY: build-blackarch
build-blackarch:
	@echo "Building BlackArch image $(BLACKCART_FULL_IMAGE_NAME)"
	docker buildx build --platform linux/amd64,linux/arm64 -t $(BLACKCART_FULL_IMAGE_NAME) --push .
	docker buildx build --platform linux/amd64,linux/arm64 -t $(BLACKCART_LATEST_IMAGE_NAME) --push .
# Tag the built image as latest - This step is not needed with --push, but kept for reference
# .PHONY: tag-latest
# tag-latest:
# 	@echo "Tagging $(BLACKCART_FULL_IMAGE_NAME) as latest"
# 	docker tag $(BLACKCART_FULL_IMAGE_NAME) $(BLACKCART_LATEST_IMAGE_NAME)

# Push both tags to Docker Hub - This step is covered by --push in build-blackarch
.PHONY: push-images
push-images:
	@echo "Pushing images to Docker Hub"
	# These commands are not needed because --push in the build step does the job
	# docker push $(BLACKCART_FULL_IMAGE_NAME)
	# docker push $(BLACKCART_LATEST_IMAGE_NAME)

# Login to Docker Hub
.PHONY: login
login:
	@echo "Logging in to Docker Hub..."
	docker login

# Remove the buildx builder
.PHONY: clean-builder
clean-builder:
	-@docker buildx rm $(BUILDER_NAME)
