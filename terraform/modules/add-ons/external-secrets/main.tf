resource "helm_release" "external_secrets" {
  name       = "external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  version    = "0.16.1" 
  namespace  = "external-secrets"
  create_namespace = true

  set {
    name  = "serviceAccount.name"
    value = "external-secrets-sa"
  }

  set {
    name = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.external_secrets_role.arn
  }
}


resource "kubernetes_manifest" "cluster_secret_store" {
  manifest = {
    apiVersion = "external-secrets.io/v1beta1"
    kind       = "ClusterSecretStore"
    metadata = {
      name      = "aws-secrets-manager-store"
    }
    spec = {
      provider = {
        aws = {
          service = "SecretsManager"
          region  = data.aws_region.current.name
          auth = {
            jwt = {
              serviceAccountRef = {
                name      = "external-secrets-sa"
                namespace = "external-secrets"
              }
            }
          }
        }
      }
    }
  }
}