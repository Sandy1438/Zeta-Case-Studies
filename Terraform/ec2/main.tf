// data "aws_ami" "ami" {

//   most_recent = true
//   owners           = [var.ami_details.owner]

//     filter {
//       name   = var.ami_details.ami-name
//       values = [var.ami_details.ami-values]
//     }

//     filter {
//     name   = "root-device-type"
//     values = [var.ami_details.ami-root-devce-type]
//     }
// }

data "aws_key_pair" "key" {
  key_name = var.ssh_key_pair
}

resource "aws_instance" "app" {
  count                  = var.app_instance_details.instance_count
  ami                    = var.ami_details
  key_name               = data.aws_key_pair.key.key_name
  instance_type          = var.app_instance_details.instance_type
  subnet_id              = var.public_subnet_ids[count.index]
  vpc_security_group_ids = [var.app-sg]

  tags = {
    Name = "Zeta-app-instance"
  }
}

resource "aws_instance" "db" {
  count                  = var.app_instance_details.instance_count
  ami                    = var.ami_details
  key_name               = data.aws_key_pair.key.key_name
  instance_type          = var.app_instance_details.instance_type
  subnet_id              = var.public_subnet_ids[count.index]
  vpc_security_group_ids = [var.db-sg]

  tags = {
    Name = "Zeta-db-instance"
  }
}