terraform {
  backend "s3" {
    bucket = "mycomponents-tfstate-jb"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
}
