output "bastion_instance_id" {
  value = aws_instance.bastion_host.id
}

output "bastion_public_ip" {
  value = aws_instance.bastion_host.public_ip
}

output "bastion_security_group_id" {
  value = aws_security_group.bastion_sg.id
}
