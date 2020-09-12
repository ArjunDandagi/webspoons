resource "aws_security_group" "port_3306" {
  ingress {
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "webspoonsdbfortask4"
  username             = var.username
  password             = var.password
  parameter_group_name = "default.mysql5.7"
  vpc_security_group_ids = [aws_security_group.port_3306.id]
  backup_retention_period = 1
  apply_immediately = true
}

output "db_endpoint" {
  value = aws_db_instance.default.address
}
variable "username" {}
variable "password" {}