.PHONY: phony
phony: help

# Provide versions of Terraform and Terragrunt to use with this Docker image
TF_VERSION := 0.14.9
TG_VERSION := 0.28.18

# GitHub Actions bogus variables
GITHUB_REF ?= refs/heads/null
GITHUB_SHA ?= aabbccddeeff
VERSION_PREFIX ?=

# Set version tags
TF_LATEST := $(shell curl -s 'https://api.github.com/repos/hashicorp/terraform/releases/latest' | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/^v//')
TG_LATEST := $(shell curl -s 'https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest' | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/^v//')
VERSION := tf-$(TF_VERSION)-tg-$(TG_VERSION)
VERSION_LATEST := tf-$(TF_LATEST)-tg-$(TG_LATEST)

# Other variables and constants
CURRENT_BRANCH := $(shell echo $(GITHUB_REF) | sed 's/refs\/heads\///')
GITHUB_SHORT_SHA := $(shell echo $(GITHUB_SHA) | cut -c1-7)
DOCKER_USER_ID := christophshyper
DOCKER_ORG_NAME := devopsinfra
DOCKER_IMAGE := docker-terragrunt
DOCKER_NAME := $(DOCKER_ORG_NAME)/$(DOCKER_IMAGE)
GITHUB_USER_ID := ChristophShyper
GITHUB_ORG_NAME := devops-infra
GITHUB_NAME := $(GITHUB_ORG_NAME)/$(DOCKER_IMAGE)
BUILD_DATE := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
FLAVOURS := aws azure aws-azure gcp aws-gcp azure-gcp aws-azure-gcp

# Some cosmetics
SHELL := bash
TXT_RED := $(shell tput setaf 1)
TXT_GREEN := $(shell tput setaf 2)
TXT_YELLOW := $(shell tput setaf 3)
TXT_RESET := $(shell tput sgr0)
define NL


endef

# Main actions

.PHONY: help
help: ## Display help prompt
	$(info Available options:)
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(TXT_YELLOW)%-25s $(TXT_RESET) %s\n", $$1, $$2}'


.PHONY: check
check: ## Update TF and TG versions to the newest ones
	$(info $(NL)$(TXT_GREEN) == CURRENT VERSIONS ==$(TXT_RESET))
	$(info $(TXT_GREEN)Current Terraform:$(TXT_YELLOW)  $(TF_VERSION)$(TXT_RESET))
	$(info $(TXT_GREEN)Current Terragrunt:$(TXT_YELLOW) $(TG_VERSION)$(TXT_RESET))
	$(info $(TXT_GREEN)Current tag:$(TXT_YELLOW)        $(VERSION)$(TXT_RESET))
	@if [[ $(VERSION) != $(VERSION_LATEST) ]]; then \
  		echo -e "\n$(TXT_YELLOW) == UPDATING VERSIONS ==$(TXT_RESET)"; \
  		echo -e "$(TXT_GREEN)Latest Terraform:$(TXT_YELLOW)     $(TF_LATEST)$(TXT_RESET)"; \
  		echo -e "$(TXT_GREEN)Latest Terragrunt:$(TXT_YELLOW)    $(TG_LATEST)$(TXT_RESET)"; \
  		echo -e "$(TXT_GREEN)Latest tag:$(TXT_YELLOW)           $(VERSION_LATEST)$(TXT_RESET)"; \
  		echo "VERSION_TAG=$(VERSION_LATEST)" >> $(GITHUB_ENV) ; \
		find . -type f -name "*" -print0 | xargs -0 sed -i "s/$(TG_VERSION)/$(TG_LATEST)/g"; \
		find . -type f -name "*" -print0 | xargs -0 sed -i "s/$(TF_VERSION)/$(TF_LATEST)/g"; \
	else \
		echo "VERSION_TAG=null" >> $(GITHUB_ENV) ; \
		echo -e "\n$(TXT_YELLOW) == NO CHANGES NEEDED ==$(TXT_RESET)"; \
	fi


.PHONY: build
build: build-plain build-aws build-azure build-aws-azure build-gcp build-aws-gcp build-azure-gcp build-aws-azure-gcp ## Build all Docker images


.PHONY: build-parallel
build-parallel: ## Build all image in parallel
	@make -s build-plain VERSION_PREFIX=$(VERSION_PREFIX) &\
		make -s build-aws VERSION_PREFIX=$(VERSION_PREFIX) &\
		make -s build-azure VERSION_PREFIX=$(VERSION_PREFIX) &\
		make -s build-aws-azure VERSION_PREFIX=$(VERSION_PREFIX) &\
		make -s build-gcp VERSION_PREFIX=$(VERSION_PREFIX) &\
		make -s build-aws-gcp VERSION_PREFIX=$(VERSION_PREFIX) &\
		make -s build-azure-gcp VERSION_PREFIX=$(VERSION_PREFIX) &\
		make -s build-aws-azure-gcp VERSION_PREFIX=$(VERSION_PREFIX) &\
		wait


.PHONY: build-plain
build-plain: ## Build image without cloud CLIs
	$(info $(NL)$(TXT_GREEN)Building Docker image:$(TXT_YELLOW) $(DOCKER_NAME):$(VERSION_PREFIX)$(VERSION)$(TXT_RESET))
	@docker build \
		--build-arg TF_VERSION=$(TF_VERSION) \
		--build-arg TG_VERSION=$(TG_VERSION) \
		--build-arg VCS_REF=$(GITHUB_SHORT_SHA) \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--file=Dockerfile \
		--tag=$(DOCKER_NAME):$(VERSION_PREFIX)$(VERSION) .


.PHONY: build-aws
build-aws: ## Build image with AWS CLI
	$(info $(NL)$(TXT_GREEN)Building Docker image:$(TXT_YELLOW) $(DOCKER_NAME):$(VERSION_PREFIX)aws-$(VERSION)$(TXT_RESET))
	@docker build \
		--build-arg AWS=yes \
		--build-arg TF_VERSION=$(TF_VERSION) \
		--build-arg TG_VERSION=$(TG_VERSION) \
		--build-arg VCS_REF=$(GITHUB_SHORT_SHA) \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--file=Dockerfile \
		--tag=$(DOCKER_NAME):$(VERSION_PREFIX)aws-$(VERSION) .


.PHONY: build-azure
build-azure: ## Build image with Azure CLI
	$(info $(NL)$(TXT_GREEN)Building Docker image:$(TXT_YELLOW) $(DOCKER_NAME):$(VERSION_PREFIX)azure-$(VERSION)$(TXT_RESET))
	@docker build \
		--build-arg AZURE=yes \
		--build-arg TF_VERSION=$(TF_VERSION) \
		--build-arg TG_VERSION=$(TG_VERSION) \
		--build-arg VCS_REF=$(GITHUB_SHORT_SHA) \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--file=Dockerfile \
		--tag=$(DOCKER_NAME):$(VERSION_PREFIX)azure-$(VERSION) .


.PHONY: build-aws-azure
build-aws-azure: ## Build image with AWS and Azure CLI
	$(info $(NL)$(TXT_GREEN)Building Docker image:$(TXT_YELLOW) $(DOCKER_NAME):$(VERSION_PREFIX)aws-azure-$(VERSION)$(TXT_RESET))
	@docker build \
		--build-arg AWS=yes \
		--build-arg AZURE=yes \
		--build-arg TF_VERSION=$(TF_VERSION) \
		--build-arg TG_VERSION=$(TG_VERSION) \
		--build-arg VCS_REF=$(GITHUB_SHORT_SHA) \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--file=Dockerfile \
		--tag=$(DOCKER_NAME):$(VERSION_PREFIX)aws-azure-$(VERSION) .


.PHONY: build-gcp
build-gcp: ## Build image with GCP CLI
	$(info $(NL)$(TXT_GREEN)Building Docker image:$(TXT_YELLOW) $(DOCKER_NAME):$(VERSION_PREFIX)gcp-$(VERSION)$(TXT_RESET))
	@docker build \
		--build-arg GCP=yes \
		--build-arg TF_VERSION=$(TF_VERSION) \
		--build-arg TG_VERSION=$(TG_VERSION) \
		--build-arg VCS_REF=$(GITHUB_SHORT_SHA) \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--file=Dockerfile \
		--tag=$(DOCKER_NAME):$(VERSION_PREFIX)gcp-$(VERSION) .


.PHONY: build-aws-gcp
build-aws-gcp: ## Build image with AWS and GCP CLI
	$(info $(NL)$(TXT_GREEN)Building Docker image:$(TXT_YELLOW) $(DOCKER_NAME):$(VERSION_PREFIX)aws-gcp-$(VERSION)$(TXT_RESET))
	@docker build \
		--build-arg AWS=yes \
		--build-arg GCP=yes \
		--build-arg TF_VERSION=$(TF_VERSION) \
		--build-arg TG_VERSION=$(TG_VERSION) \
		--build-arg VCS_REF=$(GITHUB_SHORT_SHA) \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--file=Dockerfile \
		--tag=$(DOCKER_NAME):$(VERSION_PREFIX)aws-gcp-$(VERSION) .


.PHONY: build-azure-gcp
build-azure-gcp: ## Build image with Azure and GCP CLI
	$(info $(NL)$(TXT_GREEN)Building Docker image:$(TXT_YELLOW) $(DOCKER_NAME):$(VERSION_PREFIX)azure-gcp-$(VERSION)$(TXT_RESET))
	@docker build \
		--build-arg AZURE=yes \
		--build-arg GCP=yes \
		--build-arg TF_VERSION=$(TF_VERSION) \
		--build-arg TG_VERSION=$(TG_VERSION) \
		--build-arg VCS_REF=$(GITHUB_SHORT_SHA) \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--file=Dockerfile \
		--tag=$(DOCKER_NAME):$(VERSION_PREFIX)azure-gcp-$(VERSION) .


.PHONY: build-aws-azure-gcp
build-aws-azure-gcp: ## Build image with AWS, Azure and GCP CLI
	$(info $(NL)$(TXT_GREEN)Building Docker image:$(TXT_YELLOW) $(DOCKER_NAME):$(VERSION_PREFIX)aws-azure-gcp-$(VERSION)$(TXT_RESET))
	@docker build \
		--build-arg AWS=yes \
		--build-arg AZURE=yes \
		--build-arg GCP=yes \
		--build-arg TF_VERSION=$(TF_VERSION) \
		--build-arg TG_VERSION=$(TG_VERSION) \
		--build-arg VCS_REF=$(GITHUB_SHORT_SHA) \
		--build-arg BUILD_DATE=$(BUILD_DATE) \
		--file=Dockerfile \
		--tag=$(DOCKER_NAME):$(VERSION_PREFIX)aws-azure-gcp-$(VERSION) .


.PHONY: push-docker
push-docker: ## Push to DockerHub
	$(info $(NL)$(TXT_GREEN) == STARTING DEPLOYMENT TO DOCKERHUB == $(TXT_RESET))
	$(info $(NL)$(TXT_GREEN)Logging to DockerHub$(TXT_RESET))
	@echo $(DOCKER_TOKEN) | docker login -u $(DOCKER_USER_ID) --password-stdin
	$(info $(NL)$(TXT_GREEN)Pushing image:$(TXT_YELLOW) $(DOCKER_NAME):$(VERSION_PREFIX)$(VERSION)$(TXT_RESET))
	@docker tag $(DOCKER_NAME):$(VERSION_PREFIX)$(VERSION) $(DOCKER_NAME):$(VERSION_PREFIX)latest
	@docker push $(DOCKER_NAME):$(VERSION_PREFIX)$(VERSION)
	@docker push $(DOCKER_NAME):$(VERSION_PREFIX)latest
	@for FL in $(FLAVOURS); do \
		echo -e "\n`tput setaf 2`Pushing image: `tput setaf 3`$(DOCKER_NAME):$(VERSION_PREFIX)$$FL-$(VERSION)`tput sgr0`" ;\
		docker tag $(DOCKER_NAME):$(VERSION_PREFIX)$$FL-$(VERSION) $(DOCKER_NAME):$(VERSION_PREFIX)$$FL-latest ;\
		docker push $(DOCKER_NAME):$(VERSION_PREFIX)$$FL-$(VERSION) ;\
		docker push $(DOCKER_NAME):$(VERSION_PREFIX)$$FL-latest ;\
	done


.PHONY: push-github
push-github: ## Push to GitHub Container Registry
	$(info $(NL)$(TXT_GREEN) == STARTING DEPLOYMENT TO GITHUB == $(TXT_RESET))
	$(info $(NL)$(TXT_GREEN)Logging to GitHub$(TXT_RESET))
	@echo $(GITHUB_TOKEN) | docker login https://docker.pkg.github.com -u $(GITHUB_USER_ID) --password-stdin
	$(info $(NL)$(TXT_GREEN)Pushing image:$(TXT_YELLOW) docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)$(VERSION)$(TXT_RESET))
	@docker tag $(DOCKER_NAME):$(VERSION_PREFIX)$(VERSION) docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)$(VERSION)
	@docker tag $(DOCKER_NAME):$(VERSION_PREFIX)$(VERSION) docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)latest
	@docker push docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)$(VERSION)
	@docker push docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)latest
	@for FL in $(FLAVOURS); do \
		echo -e "\n`tput setaf 2`Pushing image: `tput setaf 3`docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)$$FL-$(VERSION)`tput sgr0`" ;\
		docker tag $(DOCKER_NAME):$(VERSION_PREFIX)$$FL-$(VERSION) docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)$$FL-$(VERSION) ;\
		docker tag $(DOCKER_NAME):$(VERSION_PREFIX)$$FL-$(VERSION) docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)$$FL-latest ;\
		docker push docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)$$FL-$(VERSION) ;\
		docker push docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)$$FL-latest ;\
	done


.PHONY: push-parallel
push-parallel: ## Push all images in parallel
	$(info $(NL)$(TXT_GREEN) == STARTING DEPLOYMENT TO ALL REGISTRIES == $(TXT_RESET))
	$(info $(NL)$(TXT_GREEN)Logging to DockerHub$(TXT_RESET))
	@echo $(DOCKER_TOKEN) | docker login -u $(DOCKER_USER_ID) --password-stdin
	$(info $(NL)$(TXT_GREEN)Logging to GitHub$(TXT_RESET))
	@echo $(GITHUB_TOKEN) | docker login https://docker.pkg.github.com -u $(GITHUB_USER_ID) --password-stdin
	@echo -e "\n`tput setaf 2`Pushing image: `tput setaf 3`$(DOCKER_IMAGE):$(VERSION_PREFIX)$(VERSION)`tput sgr0`"
	@docker tag $(DOCKER_NAME):$(VERSION_PREFIX)$(VERSION) $(DOCKER_NAME):$(VERSION_PREFIX)latest
	@docker tag $(DOCKER_NAME):$(VERSION_PREFIX)$(VERSION) docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)$(VERSION)
	@docker tag $(DOCKER_NAME):$(VERSION_PREFIX)$(VERSION) docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)latest
	@docker push $(DOCKER_NAME):$(VERSION_PREFIX)$(VERSION) &\
		docker push $(DOCKER_NAME):$(VERSION_PREFIX)latest &\
		docker push docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)$(VERSION) &\
		docker push docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)latest &\
		wait
	@function tag_push() { \
			echo -e "\n`tput setaf 2`Pushing image: `tput setaf 3`$(DOCKER_IMAGE):$(VERSION_PREFIX)$$FL-$(VERSION)`tput sgr0`" ;\
			docker tag $(DOCKER_NAME):$(VERSION_PREFIX)$$FL-$(VERSION) $(DOCKER_NAME):$(VERSION_PREFIX)$$FL-latest ;\
			docker tag $(DOCKER_NAME):$(VERSION_PREFIX)$$FL-$(VERSION) docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)$$FL-$(VERSION) ;\
			docker tag $(DOCKER_NAME):$(VERSION_PREFIX)$$FL-$(VERSION) docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)$$FL-latest ;\
			docker push $(DOCKER_NAME):$(VERSION_PREFIX)$$FL-$(VERSION) &\
			docker push $(DOCKER_NAME):$(VERSION_PREFIX)$$FL-latest &\
			docker push docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)$$FL-$(VERSION) &\
			docker push docker.pkg.github.com/$(GITHUB_NAME)/$(DOCKER_IMAGE):$(VERSION_PREFIX)$$FL-latest &\
		} ;\
		for FL in $(FLAVOURS); do \
			tag_push & \
			wait ;\
		done
