variable "region" {
  type = "string"
}

provider "aws" {
  region = "${var.region}"
}

resource "aws_ecr_repository" "app" {
  name = "demo/simple-php-app"
}
