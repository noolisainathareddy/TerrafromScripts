resource "aws_iam_role" "nkit_eks_cluster_role" {
  name = "${var.eks_cluster_role_name}_${var.env}"
  assume_role_policy = jsonencode({
    Version =  "2026-03-24"
    Satement = [
        {
            Sid = "AllowClusterToCreatedandDeleteEKSResources",
            Effect =  "Allow",
            Action =  ["sts:AssumeRole"],
            Principal = {
                Service = "eks.amazonaws.com"
            }
        }
    ]
  })
}