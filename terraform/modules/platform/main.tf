locals {
  standard_labels = merge(
    {
      "app.kubernetes.io/name"       = var.app_name
      "app.kubernetes.io/managed-by" = "terraform"
      "app.kubernetes.io/part-of"    = "infra-golden-path"
      "environment"                  = var.environment
      "team"                         = var.team
    },
    var.additional_labels,
  )

  standard_annotations = merge(
    {
      "platform.example.com/environment" = var.environment
      "platform.example.com/team"        = var.team
    },
    var.additional_annotations,
  )
}

resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace

    labels      = local.standard_labels
    annotations = local.standard_annotations
  }
}

resource "kubernetes_service_account" "this" {
  count = var.create_service_account ? 1 : 0

  metadata {
    name      = var.app_name
    namespace = kubernetes_namespace.this.metadata[0].name

    labels      = local.standard_labels
    annotations = local.standard_annotations
  }
}
