variable "kubeconfig_path" {
  description = "Path to kubeconfig for the local cluster (kind/minikube)."
  type        = string
  default     = "~/.kube/config"
}

variable "kubeconfig_context" {
  description = "Optional kubeconfig context. Leave empty to use the current context."
  type        = string
  default     = ""
}

variable "namespace" {
  description = "Target namespace."
  type        = string
  default     = "demo-app-staging"
}

variable "environment" {
  description = "Environment label."
  type        = string
  default     = "staging"
}

variable "team" {
  description = "Owning team."
  type        = string
  default     = "platform"
}
