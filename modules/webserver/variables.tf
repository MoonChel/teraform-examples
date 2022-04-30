variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami_filter_values" {
  type    = list(string)
  default = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
}

variable "aws_instance_tags" {
  type = map(string)
}
