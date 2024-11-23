provider "aws" {
  region = "eu-north-1"
}

resource "aws_ecr_repository" "app_repo" {
  name = "dev-fplarache-smartlib-users-repo-yasm"
}
