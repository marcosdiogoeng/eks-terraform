resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  key_name                    = local.key_bastion
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  subnet_id                   = var.subnet_public_1a

  tags = merge(var.tags, {
    Name = "bastion-host"
  })
}