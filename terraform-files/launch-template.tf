data "template_file" "userdata" {
  template = file("${abspath(path.module)}/userdata.sh")
  vars = {
    rds-endpoint = aws_db_instance.nht-db.address
  }
}

resource "aws_launch_template" "nht-lt" {
  name          = "${var.tags}-launch-template"
  image_id      = var.image-id
  instance_type = var.instance-type
  key_name      = var.key
  monitoring {
    enabled = false
  }
  vpc_security_group_ids = ["${aws_security_group.ec2-sec-group.id}"]
  user_data              = base64encode(data.template_file.userdata.rendered)
  tags = {
    "Name" = "${var.tags}-launch-template"
  }
}

