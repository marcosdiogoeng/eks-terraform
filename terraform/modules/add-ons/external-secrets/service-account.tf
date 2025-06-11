resource "kubernetes_service_account" "external_secrets" {
  metadata {
    name      = "external-secrets-sa"
    namespace = "external-secrets"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.external_secrets_role.arn
    }
  }
}
