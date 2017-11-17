resource "aws_vpc" "vpc" {
  cidr_block = "${var.cidr_vpc}"

  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "${var.vpc_name}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  count                   = "${length(split(",", lookup(var.azs, var.region)))}"
  cidr_block              = "${cidrsubnet(var.cidr_vpc, 8, count.index)}"
  availability_zone       = "${element(split(",", lookup(var.azs, var.region)), count.index)}"
  map_public_ip_on_launch = false

  tags {
    Name = "private-${element(split(",", lookup(var.azs, var.region)), count.index)}-subnet"
  }

  depends_on = ["aws_vpc.vpc"]
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  count                   = "${length(split(",", lookup(var.azs, var.region)))}"
  cidr_block              = "${cidrsubnet(var.cidr_vpc, 8, (count.index + length(split(",", lookup(var.azs, var.region)))))}"
  availability_zone       = "${element(split(",", lookup(var.azs, var.region)), count.index)}"
  map_public_ip_on_launch = true

  tags {
    Name = "public-${element(split(",", lookup(var.azs, var.region)), count.index)}-subnet"
  }

  depends_on = ["aws_vpc.vpc"]
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id     = "${aws_vpc.vpc.id}"
  depends_on = ["aws_vpc.vpc"]
}

resource "aws_eip" "nat_gateway_eip" {
  vpc        = true
  depends_on = ["aws_internet_gateway.internet_gateway"]
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = "${aws_eip.nat_gateway_eip.id}"
  subnet_id     = "${aws_subnet.public_subnet.*.id[0]}"
  depends_on    = ["aws_internet_gateway.internet_gateway", "aws_subnet.public_subnet"]
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }

  tags {
    Name = "route_table_public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway.id}"
  }

  tags {
    Name = "route_table_private"
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = "${length(split(",", lookup(var.azs, var.region)))}"
  subnet_id      = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private_assoc" {
  count          = "${length(split(",", lookup(var.azs, var.region)))}"
  subnet_id      = "${element(aws_subnet.private_subnet.*.id,count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}
