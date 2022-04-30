data "aws_ami" "server_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = var.ami_filter_values
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.server_ami.id
  instance_type = var.instance_type

  tags = var.aws_instance_tags
}
