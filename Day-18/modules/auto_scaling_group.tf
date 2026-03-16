resource "aws_autoscaling_group" "nkit_auto_scaling_group" {
   name = "nkit_auto_scaling_group"
   max_size = 2
   min_size = 2
   desired_capacity = 2
    vpc_zone_identifier = [aws_subnet.nkit_private_subnet_1a.id, aws_subnet.nkit_private_subnet_1b.id]
   launch_template {
     id = aws_launch_template.nkit_ec2_launch_template.id
   }
   target_group_arns = [aws_lb_target_group.nkit_dev_target_group.arn]
}