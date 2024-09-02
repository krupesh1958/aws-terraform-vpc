# AMI Image: Ubuntu 22.04
data "aws_ami" "ubuntu" {
    most_recent = true
    owners      = ["099720109477"]

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }
}

# Security Group for the EC2 instances
resource "aws_instance" "web" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    key_name      = aws_key_pair.generated_key.key_name
    subnet_id     = element(module.network.subnet_ids, 0)
    vpc_security_group_ids = [aws_security_group.web_instance.id]

    tags = {
        Name = "web"
    }
}

# Generate a new key pair
resource "tls_private_key" "key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

# Save the public key in the AWS Key Pair
resource "aws_key_pair" "generated_key" {
    key_name   = var.key_name
    public_key = tls_private_key.key.public_key_openssh
}

# RDS Instance
resource "aws_db_instance" "web_db_instance" {
    allocated_storage    = 10
    db_name              = "mydb"
    engine               = "mysql"
    engine_version       = "8.0"
    instance_class       = "db.t3.micro"
    username             = "foo"
    password             = var.db_instance_password
    parameter_group_name = "default.mysql8.0"
    skip_final_snapshot  = true
    vpc_security_group_ids = [aws_security_group.rds_instance.id]
    publicly_accessible = false
    db_subnet_group_name = aws_db_subnet_group.subnet_group.name

    tags = {
        Name = "practice_db"
    }
}

resource "aws_db_subnet_group" "subnet_group" {
    name       = "practice_db_subnet_group"
    subnet_ids = [
        element(module.network.subnet_ids, 3),
        element(module.network.subnet_ids, 4),
        element(module.network.subnet_ids, 5)
    ]
}
