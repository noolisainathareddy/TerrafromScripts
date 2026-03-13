resource "aws_autoscaling_group" "nkit_auto_scaling_group" {
   name = "nkit_auto_scaling_group"
   max_size = 2
   min_size = 2
   desired_capacity = 2
   availability_zones = [aws_subnet.nkit_private_subnet_1a.id, aws_subnet.nkit_private_subnet_1b.id]
   launch_template {
     id = aws_launch_template.nkit_ec2_launch_template.id
     name = aws_launch_template.nkit_ec2_launch_template.name
     version = aws_launch_template.nkit_ec2_launch_template.latest_version
   }
}