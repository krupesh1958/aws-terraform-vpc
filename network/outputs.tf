# Terrafor output file
output "vpc_id" {
    description = "The ID of the VPC"
    value = aws_vpc.vpc.id
}
output "subnet_ids" {
    description = "The IDs of the subnets"
    value = [
        aws_subnet.subnet1.id,
        aws_subnet.subnet2.id,
        aws_subnet.subnet3.id,
        aws_subnet.subnet4.id,
        aws_subnet.subnet5.id,
        aws_subnet.subnet6.id
    ]
}
