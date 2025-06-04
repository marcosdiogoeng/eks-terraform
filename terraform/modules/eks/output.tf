output "cluster_name" {
  value = aws_eks_cluster.this.id
}

output "oidc" {
  value = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_ca_authority" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_sg_id" {
  value = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}