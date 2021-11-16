
data "aws_availability_zones" "az" {}

resource "aws_vpc" "zeta" {
    cidr_block       = var.vpc_cidr
    enable_dns_hostnames = true

    tags = {
    Name = "zeta-case-study"
    }
}

resource "aws_internet_gateway" "ig" {
    vpc_id = aws_vpc.zeta.id
    tags = {
        Name  = "zeta-case-study-igw"
    }
}

resource "aws_eip" "nat_eip" {
    vpc        = true
    depends_on = [aws_internet_gateway.ig]
}

resource "aws_subnet" "public" {
    count = var.subnet_count
    vpc_id     = aws_vpc.zeta.id
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = data.aws_availability_zones.az.names[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "zeta-public-subnet"
    }
}

resource "aws_subnet" "private" {
    count = var.subnet_count
    vpc_id     = aws_vpc.zeta.id
    cidr_block = var.private_subnet_cidr[count.index]
    availability_zone = data.aws_availability_zones.az.names[count.index]

    tags = {
        Name = "zeta-private-subnet"
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.zeta.id
    tags = {
        Name        = "zeta-private-route-table"
        }
    }

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.zeta.id
    tags = {
        Name        = "zet-public-route-table"
    }
}

resource "aws_route" "public_internet_gateway" {
    route_table_id         = aws_route_table.public.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.ig.id
}

resource "aws_nat_gateway" "nat" {
    // count = var.subnet_count
    allocation_id = aws_eip.nat_eip.id
    subnet_id     = aws_subnet.public[0].id
    depends_on    = [aws_internet_gateway.ig]
    tags = {
        Name        = "zeta-case-study-nat-gw"
    }
}

resource "aws_route" "private_nat_gateway" {
    route_table_id         = aws_route_table.private.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "public" {
    count          = var.subnet_count
    // subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
    subnet_id      = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
    count          = var.subnet_count
    subnet_id      = aws_subnet.private[count.index].id
    route_table_id = aws_route_table.private.id
}

