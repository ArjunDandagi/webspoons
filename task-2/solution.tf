data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "sids" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_availability_zones" "azs" {
  all_availability_zones = true
  exclude_names = ["us-east-1-wl1-bos-wlz-1"]
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "port_80" {
  name = "port_80_sg_for_task_2_arjun"
  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "elb" {
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    interval = 5
    target = "http:80/"
    timeout = 3
    unhealthy_threshold = 3
  }
  security_groups = [aws_security_group.port_80.id]
  availability_zones = data.aws_availability_zones.azs.names
}


module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"
  load_balancers = [aws_elb.elb.name]
  name = "web-service"

  # Launch configuration
  lc_name = "web-service-lc-task2"
  user_data = file("user-data.txt")

  image_id        = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.port_80.id]

  # Auto scaling group
  asg_name                  = "web-service-asg-task-2"
  vpc_zone_identifier       = data.aws_subnet_ids.sids.ids
  health_check_type         = "ELB"
  min_size                  = 4
  max_size                  = 6
  desired_capacity          = 4
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Name"
      value               = "web-server-task-2"
      propagate_at_launch = true
    },
  ]
}
output "dns_endpoint" {
  value = aws_elb.elb.dns_name
}