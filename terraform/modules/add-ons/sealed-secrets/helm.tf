resource "helm_release" "selead_secrets" {
  name       = "sealed-secrets"
  repository = "https://bitnami-labs.github.io/sealed-secrets"
  chart      = "sealed-secrets"
  version    = "1.10.1"
  namespace  = "kube-system"

  set {
    name  = "FullnameOverride"
    value = "selead-secret-controller"
  }
}