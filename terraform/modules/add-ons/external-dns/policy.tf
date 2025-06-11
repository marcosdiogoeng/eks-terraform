resource "aws_iam_policy" "external_dns_policy" {
  name   = "${var.project_name}-external-dns"
  policy = file("${path.module}/iam_policy.json")
  tags = merge(var.tags, {
    Name = "${var.project_name}-external-dns"
  })
}