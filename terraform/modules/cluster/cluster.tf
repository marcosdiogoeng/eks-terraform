resource "aws_eks_cluster" "this" {
  name = "${var.project_name}-cluster"

  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.31"
  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true

    subnet_ids = [
      var.subnet_public_1a,
      var.subnet_public_1b
    ]
  }

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  tags = merge(var.tags, {
    Name = "${var.project_name}-cluster"
  })

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_role_attachment
  ]
}