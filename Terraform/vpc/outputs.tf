output "public_subnet_ids" {
    value = aws_subnet.public.*.id
}

output "private_subnet_ids" {
    value = aws_subnet.private.*.id
}

output "vpc_id" {
    value = aws_vpc.zeta.id
}

output "db_sg_id" {
    value = aws_security_group.db-sg.*.id
}

output "app_sg_id" {
    value = aws_security_group.app-sg.*.id
}