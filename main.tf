terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
}

provider "aws" {
  alias  = "eu_central_1"
  region = "eu-central-1"
}

# how resources are specified
# resource "<provider>_<resource_type>" "name" {
#     key = "value"
# }

# 1 - declare ec2 instance with specific AMI
# declare an image that will be used for ec2 instance
# data source will read info about AMI and provide it to terraform
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  tags = {
    Name = "HelloWorld"
  }
}


# 2 - declare a subnet in a vpc
# reference resource via <resource_type>.<resource_name>.<resource_attribute>
resource "aws_vpc" "production" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "production"
  }
}

resource "aws_subnet" "production" {
  vpc_id     = aws_vpc.production.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "production-subnet"
  }
}


module "my_webserver" {
  source = "./modules/webserver"

  ami_filter_values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  tags = {
    Name = "my_webserver"
  }
}
