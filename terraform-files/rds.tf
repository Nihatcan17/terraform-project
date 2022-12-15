resource "aws_db_instance" "nht-db" {
  allocated_storage      = 10
  db_name                = "phonebook"
  engine                 = "mysql"
  engine_version         = "8.0.25"
  instance_class         = "db.t2.micro"
  username               = "admin"
  password               = var.db-password
  skip_final_snapshot    = true
  vpc_security_group_ids = ["${aws_security_group.rds-sec.id}"]
  multi_az               = false
  tags = {
    "Name" = "${var.tags}-database"
  }
}



