resource "aws_iam_role" "external_secrets_role" {
  name = "${var.project_name}-external-secrets-role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${local.oidc}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${local.oidc}:sub": "system:serviceaccount:external-secrets:external-secrets-sa"
                }
            }
        }
    ]
}
  EOF

  tags = merge(var.tags, {
    Name = "${var.project_name}-external-secrets-role"
  })
}

resource "aws_iam_policy" "external_secrets_policy" {
  name   = "${var.project_name}-external-secrets-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecrets"
        ],
        Resource = "*"
      }
    ]
  })
  
}
resource "aws_iam_role_policy_attachment" "external_dns_role_attachment" {
  role       = aws_iam_role.external_secrets_role.name
  policy_arn = aws_iam_policy.external_secrets_policy.arn
}