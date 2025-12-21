resource "aws_instance" "ec2_instance_east_1" {
  instance_type = var.allowed_instace_types[0]
  ami           = var.ec2_ami_id
  tags          = var.tags

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [tags, ami]
    precondition {
      condition     = (var.tags.Env == "Dev")
      error_message = "Tag is not present"
    }
    prevent_destroy = false
  }
} 