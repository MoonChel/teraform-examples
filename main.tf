terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  shared_config_files = ["./aws/config"]
  shared_credentials_files = ["./aws/credentials"]
  profile = "terraform-tutorial"
}

# how resources are specified
# resource "<provider>_<resource_type>" "name" {
#     key = "value"
# }