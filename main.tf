
//le provider AWS 

provider "aws" {
  region = "eu-north-1"
}

// repository ECR

resource "aws_ecr_repository" "dev-fplarache-smartlib-users-repo-yasm" {
  name = "dev-fplarache-smartlib-users-repo-yasm"
}

//cluster ECS

resource "aws_ecs_cluster" "dev-fplarache-smartlib-users-fgcluster-yasm" {
  name = "dev-fplarache-smartlib-users-fgcluster-yasm"
}

// définition de tâche ECS

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

//service ECS

resource "aws_ecs_service" "dev-fplarache-smartlib-users-fgservice-yasm" {
  cluster        = aws_ecs_cluster.dev-fplarache-smartlib-users-fgcluster-yasm.id
  task_definition = aws_ecs_task_definition.dev-fplarache-smartlib-users-td-yasm.arn
  desired_count  = 1
}


