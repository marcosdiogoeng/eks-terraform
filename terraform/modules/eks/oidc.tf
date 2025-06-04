data "tls_certificate" "eks_certificate_oidc" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "this" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.eks_certificate_oidc.certificates[*].sha1_fingerprint
  url             = data.tls_certificate.eks_certificate_oidc.url
  tags = merge(var.tags, {
    Name = "${var.project_name}-oidc"
  })
}