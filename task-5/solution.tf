data "aws_db_instance" "task-4-db" {
  db_instance_identifier = "terraform-20200912103843804200000001"
}

resource "aws_db_instance" "read_replica" {
  instance_class = "db.t2.micro"
  replicate_source_db = data.aws_db_instance.task-4-db.db_instance_arn
}

output "db_endpoint" {
  value =  aws_db_instance.read_replica.address
}