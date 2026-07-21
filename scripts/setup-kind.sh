#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="${CLUSTER_NAME:-golden-path}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v kind >/dev/null 2>&1; then
  echo "kind is required: https://kind.sigs.k8s.io/docs/user/quick-start/#installation"
  exit 1
fi

if kind get clusters 2>/dev/null | grep -qx "${CLUSTER_NAME}"; then
  echo "Cluster '${CLUSTER_NAME}' already exists."
else
  kind create cluster --name "${CLUSTER_NAME}" --config="${SCRIPT_DIR}/kind-config.yaml"
fi

kubectl cluster-info --context "kind-${CLUSTER_NAME}"
echo "Context: kind-${CLUSTER_NAME}"
