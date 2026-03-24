resource "aws_iam_role" "nkit_eks_cluster_role" {
  name = "${var.eks_cluster_role_name}_${var.env}"
  assume_role_policy = jsonencode({
    Version =  var.eks_iam_role_Version
    Statement = [
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

resource "aws_iam_role_policy_attachment" "attach_eks_role_with_ploicy" {
  role = aws_iam_role.nkit_eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}