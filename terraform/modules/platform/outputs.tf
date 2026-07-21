output "namespace" {
  description = "Provisioned namespace name."
  value       = kubernetes_namespace.this.metadata[0].name
}

output "service_account_name" {
  description = "ServiceAccount name, empty if not created."
  value       = var.create_service_account ? kubernetes_service_account.this[0].metadata[0].name : ""
}

output "labels" {
  description = "Standard labels applied to platform resources."
  value       = local.standard_labels
}
