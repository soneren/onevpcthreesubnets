resource "aws_internet_gateway" "soner-igw" {
    vpc_id = "${aws_vpc.soner-vpc.id}"
    tags = {
        Name = "soner-igw"
    }
}
#routetable-public
resource "aws_route_table" "soner-public-crt" {
    vpc_id = "${aws_vpc.soner-vpc.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.soner-igw.id}" 
    }
    
    tags = {
        Name = "soner-public-crt"
    }
}
#routetable-private
resource "aws_route_table" "soner-private-crt" {
    vpc_id = "${aws_vpc.main-vpc.id}"
    
    route {
        //associated subnet can reach everywhere
        cidr_block = "0.0.0.0/0" 
        //CRT uses this IGW to reach internet
        gateway_id = "${aws_internet_gateway.soner-igw.id}" 
    }
    
    tags {
        Name = "soner-private-crt"
    }
}
#Associate Crt
resource "aws_route_table_association" "soner-crta-public-subnet-1"{
    subnet_id = "${aws_subnet.soner-subnet-public-1.id}"
    route_table_id = "${aws_route_table.soner-public-crt.id}"
}
resource "aws_route_table_association" "soner-crta-private-subnet-1"{
    subnet_id = "${aws_subnet.soner-subnet-private-1.id}"
    route_table_id = "${aws_route_table.soner-public-crt.id}"
}
resource "aws_route_table_association" "soner-crta-private-subnet-2"{
    subnet_id = "${aws_subnet.soner-subnet-private-2.id}"
    route_table_id = "${aws_route_table.soner-public-crt.id}"
}
#create sg
resource "aws_security_group" "ssh-allowed" {
    vpc_id = "${aws_vpc.soner-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["78.174.124.61/32"] #myhome
    }
    tags = {
        Name = "ssh-allowed"
    }
}