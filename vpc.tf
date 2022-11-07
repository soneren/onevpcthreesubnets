resource "aws_vpc" "soner-vpc" {
    cidr_block = "10.0.0.0/24"
    enable_dns_support = "true" #gives you an internal domain name
    enable_dns_hostnames = "true" #gives you an internal host name
    enable_classiclink = "false"
    instance_tenancy = "default"    
    tags = {Name = "soner-vpc"}
}

resource "aws_subnet" "public_subnet" {
    vpc_id = "${aws_vpc.soner-vpc.id}"
    cidr_block = "10.0.0.0/26"
    map_public_ip_on_launch = "true" //it makes this a public subnet
    availability_zone = "eu-west-1a"
    tags = {
        Name = "public_subnet"
    }
}
resource "aws_route_table_association" "public_subnet_asso" {
 subnet_id      = aws_subnet.public_subnet.id
 route_table_id = aws_route_table.soner-public-crt.id
}
resource "aws_subnet" "private_subnet" {
    vpc_id = "${aws_vpc.soner-vpc.id}"
    cidr_block = "10.0.0.128/26"
    map_public_ip_on_launch = "false" //it makes this a private subnet
    availability_zone = "eu-west-1a"
    tags {
        Name = "private_subnet"
    }
}
resource "aws_route_table_association" "private_subnet_asso" {
 subnet_id      = aws_subnet.private_subnet.id
 route_table_id = aws_route_table.soner-private-crt.id
}
resource "aws_subnet" "database_subnet" {
    vpc_id = "${aws_vpc.soner-vpc.id}"
    cidr_block = "10.0.0.192/26"
    map_public_ip_on_launch = "false" //it makes this a private subnet
    availability_zone = "eu-west-1b"
    tags {
        Name = "database_subnet"
    }
}
resource "aws_route_table_association" "private_subnet_asso" {
 subnet_id      = aws_subnet.private_subnet.id
 route_table_id = aws_route_table.soner-private-crt.id
}