terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.50"
    }
  }

  required_version = ">= 1.4.0"
}

provider "aws" {
  profile = "terraform"
}

resource "aws_vpc" "net-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    name = "net-vpc"
  }
}

resource "aws_subnet" "net-pub-subnet-1" {
  vpc_id     = aws_vpc.net-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    name = "net-pub-subnet-1"
  }
}

resource "aws_subnet" "net-pri-subnet-2" {
  vpc_id     = aws_vpc.net-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    name = "net-pri-subnet-2"
  }
}

resource "aws_route_table" "net-rt" {
  vpc_id = aws_vpc.net-vpc.id
}

resource "aws_route_table_association" "subnet-associate-1" {
  subnet_id      = aws_subnet.net-pub-subnet-1.id
  route_table_id = aws_route_table.net-rt.id
}

resource "aws_internet_gateway" "net-igw" {
  vpc_id = aws_vpc.net-vpc.id
}