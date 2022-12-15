

resource "aws_security_group" "ec2-sec-group" {
  name        = "${var.tags}-ec2-sec-group"
  description = "created-for-ec2"
  vpc_id      = data.aws_vpc.default_vpc.id
  tags = {
    "Name" = "${var.tags}-ec2-sec"
  }



  ingress {
    to_port         = 80
    from_port       = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.load-balancer-sec.id}"]

  }

  egress {
    to_port     = 0
    from_port   = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}




resource "aws_security_group" "rds-sec" {
  name        = "${var.tags}-rds-sec-group"
  description = "for-rds"
  vpc_id      = data.aws_vpc.default_vpc.id
  tags = {
    "Name" = "${var.tags}-rds-sec"
  }

  ingress {
    to_port         = 3306
    from_port       = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ec2-sec-group.id}"]


  }

  egress {
    to_port         = 0
    from_port       = 0
    protocol        = -1
    security_groups = ["${aws_security_group.ec2-sec-group.id}"]


  }

}

resource "aws_security_group" "load-balancer-sec" {
  name        = "${var.tags}-load-balancer-sec"
  description = "for-lb"
  vpc_id      = data.aws_vpc.default_vpc.id
  tags = {
    "Name" = "${var.tags}-lb-sec"
  }

  ingress {
    to_port     = 80
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}