variable "namespace" {
  description = "Kubernetes namespace name for the application."
  type        = string
}

variable "environment" {
  description = "Environment label (dev, staging, prod)."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "team" {
  description = "Owning team name, applied as a standard label."
  type        = string
  default     = "platform"
}

variable "app_name" {
  description = "Application name used in labels and service account naming."
  type        = string
  default     = "demo-app"
}

variable "additional_labels" {
  description = "Extra labels merged into the standard label set."
  type        = map(string)
  default     = {}
}

variable "additional_annotations" {
  description = "Extra annotations merged into the standard annotation set."
  type        = map(string)
  default     = {}
}

variable "create_service_account" {
  description = "Whether to create a dedicated ServiceAccount for the app."
  type        = bool
  default     = true
}
