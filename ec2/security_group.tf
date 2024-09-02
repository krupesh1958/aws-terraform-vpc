# Web Instance Security Group
resource "aws_security_group" "web_instance" {
    vpc_id      = module.network.vpc_id
    name        = "allow_tls"
    description = "Allow tls to inbound and outbound traffic"

    ingress {
        description = "Allow HTTP from VPC"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow HTTPS from VPC"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Outbound for ssh"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "web_instance"
    }
}

# RDS Security Group
resource "aws_security_group" "rds_instance" {
    vpc_id      = module.network.vpc_id
    name        = "allow_mysql"
    description = "Allow MySQL to inbound and outbound traffic"

    ingress {
        description = "Allow MySQL from VPC"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "rds_instance"
    }
}