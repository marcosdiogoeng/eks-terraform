terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.78.0"
    }
  }
  backend "s3" {
    bucket = "tfstate-dev-339712846642"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }

}

provider "aws" {
  region = "us-east-1"
}