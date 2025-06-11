resource "aws_iam_role" "ebs_csi_role" {
  name = "${var.project_name}-ebs-csi-role"

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
                    "oidc.eks.${data.aws_region.current.name}.amazonaws.com/id/${local.oidc}:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
                }
            }
        }
    ]
}
  EOF

  tags = merge(var.tags, {
    Name = "${var.project_name}-ebs-csi-role"
  })
}


resource "aws_iam_policy" "ebs_csi_policy" {
  name        = "AmazonEBSCSIDriverPolicy"
  description = "Policy for EBS CSI Driver to manage EBS volumes"
  policy      = file("${path.module}/ebs-csi-policy.json")
}

resource "aws_iam_role_policy_attachment" "ebs_csi_policy_attachment" {
  role       = aws_iam_role.ebs_csi_role.name
  policy_arn = aws_iam_policy.ebs_csi_policy.arn
}
