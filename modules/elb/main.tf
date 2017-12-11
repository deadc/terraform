data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "describe_instances" {
  name = "DescribeInstances"
  role = "${aws_iam_role.default_iam_role.id}"

  policy = <<EOF
{
     "Version": "2012-10-17",
     "Statement": [{
        "Effect": "Allow",
        "Action": [
          "ec2:DescribeInstances"
        ],
        "Resource": "*"
      }
     ]
}
EOF
}

resource "aws_iam_role" "default_iam_role" {
  name               = "aws-${var.environment}-${var.app_name}-role"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role_policy.json}"
}

resource "aws_iam_instance_profile" "default_instance_profile" {
  name = "aws-${var.environment}-${var.app_name}-profile"
  role = "${aws_iam_role.default_iam_role.name}"
}

resource "aws_security_group" "instance_security_group" {
  name   = "aws-${var.environment}-${var.app_name}-sg"
  vpc_id = "${var.vpc_id}"
}

resource "aws_instance" "ec2_generic_instance" {
  count                       = "${var.number_of_instances}"
  ami                         = "${lookup(var.aws_amis, var.region)}"
  key_name                    = "${var.key_pair}"
  subnet_id                   = "${var.subnet_id}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = "${var.public_ip}"
  iam_instance_profile        = "${aws_iam_instance_profile.default_instance_profile.id}"

  vpc_security_group_ids = [
    "${aws_security_group.instance_security_group.id}",
    "${var.default_security_groups}",
  ]

  tags {
    Name        = "aws-${var.environment}-${var.app_name}"
    Environment = "${var.environment}"
    Backup      = "${var.backup}"
    Application = "${var.app_name}"
  }
}

resource "aws_security_group" "elb_security_group" {
  name = "aws-${var.environment}-${var.app_name}-elb-sg"

  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "generic_elb_web" {
  name            = "aws-${var.environment}-${var.app_name}-elb"
  subnets         = ["${var.elb_subnets}"]
  security_groups = ["${aws_security_group.elb_security_group.id}"]
  internal        = "${var.elb_internal}"

  listener {
    instance_port     = 3000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:3000/"
    interval            = 30
  }

  instances                   = ["${aws_instance.ec2_generic_instance.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
}

resource "aws_lb_cookie_stickiness_policy" "default" {
  name                     = "lbpolicy"
  load_balancer            = "${aws_elb.generic_elb_web.id}"
  lb_port                  = 80
  cookie_expiration_period = 600
}
