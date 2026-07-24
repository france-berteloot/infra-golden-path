.PHONY: help pre-commit tooling-pull tooling-shell helm-lint helm-template \
        setup-kind tf-init tf-plan tf-apply helm-install-staging

TOOLING_IMAGE ?= ghcr.io/france-berteloot/docker-tooling:1.0.0
NAMESPACE ?= demo-app-staging

help:
	@echo "Local developer targets:"
	@echo "  pre-commit           Run all pre-commit hooks (same as CI)"
	@echo "  tooling-pull         Pull shared CI tooling image from GHCR"
	@echo "  tooling-shell        Shell inside tooling image"
	@echo "  helm-lint            Lint demo-app chart"
	@echo "  helm-template        Render demo-app chart (staging values)"
	@echo ""
	@echo "Optional debug (deploy is done in CI/CD — see .github/workflows/cd.yml):"
	@echo "  setup-kind           Create local kind cluster"
	@echo "  tf-init              Terraform init (local env)"
	@echo "  tf-plan              Terraform plan"
	@echo "  tf-apply             Terraform apply"
	@echo "  helm-install-staging Deploy demo-app to staging namespace"

pre-commit:
	pre-commit run --all-files

tooling-pull:
	docker pull $(TOOLING_IMAGE)

tooling-shell: tooling-pull
	docker run --rm -it \
		--user "$$(id -u):$$(id -g)" \
		-e HOME=/tmp \
		-v "$(CURDIR):/work" \
		-w /work \
		$(TOOLING_IMAGE) bash

helm-lint:
	helm lint helm/charts/demo-app

helm-template:
	helm template demo-app helm/charts/demo-app -f helm/charts/demo-app/values-staging.yaml

# --- Optional local debug (CI/CD is the canonical deploy path) ---

setup-kind:
	bash scripts/setup-kind.sh

tf-init:
	cd terraform/environments/local && terraform init

tf-plan:
	cd terraform/environments/local && terraform plan

tf-apply:
	cd terraform/environments/local && terraform apply

helm-install-staging: tf-apply
	helm upgrade --install demo-app helm/charts/demo-app \
		-f helm/charts/demo-app/values-staging.yaml \
		-n $(NAMESPACE)
