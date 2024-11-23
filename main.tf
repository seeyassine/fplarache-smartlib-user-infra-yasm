provider "aws" {
  region = "eu-north-1"
}

resource "aws_ecr_repository" "dev-fplarache-smartlib-users-repo-yasm" {
  name = "dev-fplarache-smartlib-users-repo-yasm"
}

resource "aws_ecs_cluster" "app_cluster" {
  name = "dev-fplarache-smartlib-users-fgcluster-yasm"
}


resource "aws_ecs_task_definition" "dev-fplarache-smartlib-users-td-yasm" {
  family                = "dev-fplarache-smartlib-users-td-yasm"
  container_definitions = jsonencode([{
    name  = "dev-fplarache-smartlib-user-yasm-container"
    image = aws_ecr_repository.dev-fplarache-smartlib-users-repo-yasm.repository_url
    memory = 512
    cpu    = 256
    essential = true
  }])
}

