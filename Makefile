# Makefile for building and pushing Docker images for Kali and BlackArch

# Common Variables
VERSION := 1.0.5
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
all: build-blackarch push-blackarch

# Create Buildx builder
.PHONY: create-builder
create-builder:
	-docker buildx create --name $(BUILDER_NAME) --use

# BlackArch Image Targets

.PHONY: build-blackarch
build-blackarch: create-builder
	@echo "Building BlackArch image $(BLACKCART_FULL_IMAGE_NAME)"
	docker buildx build --platform linux/amd64,linux/arm64 -t $(BLACKCART_FULL_IMAGE_NAME) --push .
	@echo "Tagging BlackArch image as latest"
	docker buildx build --platform linux/amd64,linux/arm64 -t $(BLACKCART_LATEST_IMAGE_NAME) --push .

.PHONY: push-blackarch
push-blackarch:
	@echo "Pushing BlackArch images"
	docker push $(BLACKCART_FULL_IMAGE_NAME)
	docker push $(BLACKCART_LATEST_IMAGE_NAME)

# Login to Docker Hub
.PHONY: login
login:
	@echo "Logging in to Docker Hub..."
	docker login

# Remove the buildx builder
.PHONY: clean-builder
clean-builder:
	-@docker buildx rm $(BUILDER_NAME)
