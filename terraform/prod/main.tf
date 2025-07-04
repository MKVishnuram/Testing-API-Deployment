terraform {
  required_version = ">= 1.0.0" # Ensure that the Terraform version is 1.0.0 or higher

  required_providers {
    aws = {
      source = "hashicorp/aws" # Specify the source of the AWS provider
      version = "~> 4.0"        # Use a version of the AWS provider that is compatible with version
    }
  }
}

provider "aws" {
  region = "ap-south-1" # Set the AWS region to US East (N. Virginia)
}

resource "aws_instance" "aws_example" {
  tags = {
    Name = "ExampleInstance" # Tag the instance with a Name tag for easier identification
  }
}