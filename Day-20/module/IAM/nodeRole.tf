resource "aws_iam_role" "nkit_eks_node_role" {
  name = "${var.eks_node_role_name}_${var.env}"
  assume_role_policy = jsonencode(
    {
        Version = var.eks_iam_role_Version
        Statement = [
            {
                Sid = "AllowNodeToCreatedandDeleteComputeResources"
                Effect = "Allow"
                Action = ["sts:AssumeRole"]
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  role = aws_iam_role.nkit_eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  role = aws_iam_role.nkit_eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  role = aws_iam_role.nkit_eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}