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
  associate_public_ip_address = "${var.attach_eip ? var.attach_eip : var.public_ip}"
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

resource "aws_eip" "instance_eip" {
  count                     = "${var.attach_eip ? 1 : 0}"
  vpc                       = true
  instance                  = "${element(aws_instance.ec2_generic_instance.*.id,count.index)}"
  associate_with_private_ip = "${element(aws_instance.ec2_generic_instance.*.private_ip,count.index)}"
}
