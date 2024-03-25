# Makefile for building and pushing Docker images for Kali and BlackArch

# Common Variables
VERSION := 1.0.0
DOCKER_USERNAME := erdemozgen
REGISTRY := docker.io

# Docker Buildx builder name
BUILDER_NAME := mybuilder

# Enable Docker BuildKit for building images
export DOCKER_BUILDKIT=1

# Kali Linux Image Variables
KALI_IMAGE_NAME := blackcart-kali
KALI_FULL_IMAGE_NAME := $(REGISTRY)/$(DOCKER_USERNAME)/$(KALI_IMAGE_NAME):$(VERSION)
KALI_LATEST_IMAGE_NAME := $(REGISTRY)/$(DOCKER_USERNAME)/$(KALI_IMAGE_NAME):latest

# BlackArch Image Variables
BLACKARCH_IMAGE_NAME := blackcart-blackarch
BLACKARCH_FULL_IMAGE_NAME := $(REGISTRY)/$(DOCKER_USERNAME)/$(BLACKARCH_IMAGE_NAME):$(VERSION)
BLACKARCH_LATEST_IMAGE_NAME := $(REGISTRY)/$(DOCKER_USERNAME)/$(BLACKARCH_IMAGE_NAME):latest

# Default target
.PHONY: all
all: build-kali push-kali build-blackarch push-blackarch

# Create Buildx builder
.PHONY: create-builder
create-builder:
	-docker buildx create --name $(BUILDER_NAME) --use

# Kali Linux Image Targets

.PHONY: build-kali
build-kali: create-builder
	docker buildx build --platform linux/amd64,linux/arm64 -t $(KALI_FULL_IMAGE_NAME) --push .
	docker buildx build --platform linux/amd64,linux/arm64 -t $(KALI_LATEST_IMAGE_NAME) --push .

.PHONY: push-kali
push-kali:
	docker push $(KALI_FULL_IMAGE_NAME)
	docker push $(KALI_LATEST_IMAGE_NAME)

# BlackArch Image Targets

.PHONY: build-blackarch
build-blackarch: create-builder
	docker buildx build --platform linux/amd64,linux/arm64 -t $(BLACKARCH_FULL_IMAGE_NAME) --push .
	docker buildx build --platform linux/amd64,linux/arm64 -t $(BLACKARCH_LATEST_IMAGE_NAME) --push .

.PHONY: push-blackarch
push-blackarch:
	docker push $(BLACKARCH_FULL_IMAGE_NAME)
	docker push $(BLACKARCH_LATEST_IMAGE_NAME)

# Login to Docker Hub
.PHONY: login
login:
	@echo "Logging in to Docker Hub..."
	docker login

# Remove the buildx builder
.PHONY: clean-builder
clean-builder:
	-@docker buildx rm $(BUILDER_NAME)
