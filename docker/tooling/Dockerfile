# Tooling image — Terraform, Helm, kubeconform, pre-commit (hooks pré-installés)
FROM python:3.12-slim-bookworm

ARG TERRAFORM_VERSION=1.9.0
ARG HELM_VERSION=3.16.0
ARG KUBECONFORM_VERSION=0.6.7

RUN apt-get update \
  && apt-get install -y --no-install-recommends git curl ca-certificates unzip \
  && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" \
      -o /tmp/terraform.zip \
  && unzip /tmp/terraform.zip -d /usr/local/bin \
  && rm /tmp/terraform.zip

RUN curl -fsSL "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" \
    | tar xz -C /tmp \
  && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
  && rm -rf /tmp/linux-amd64

RUN curl -fsSL "https://github.com/yannh/kubeconform/releases/download/v${KUBECONFORM_VERSION}/kubeconform-linux-amd64.tar.gz" \
    | tar xz -C /usr/local/bin

RUN pip install --no-cache-dir pre-commit==4.0.1

WORKDIR /work

# Pré-télécharge les environnements pre-commit pour accélérer la CI
COPY .pre-commit-config.yaml /tmp/.pre-commit-config.yaml
RUN git init /tmp/warmup \
  && cp /tmp/.pre-commit-config.yaml /tmp/warmup/.pre-commit-config.yaml \
  && cd /tmp/warmup \
  && pre-commit install-hooks \
  && rm -rf /tmp/warmup /tmp/.pre-commit-config.yaml

RUN git config --global --add safe.directory /work

ENTRYPOINT []
CMD ["bash"]
