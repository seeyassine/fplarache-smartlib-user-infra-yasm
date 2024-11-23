
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
  execution_role_arn    = aws_iam_role.ecs_task_execution_role.arn     //Associer le rôle IAM à votre définition de tâche ECS
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


//le rôle IAM pour ECS

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

//l'ajoutez des politiques au rôle

resource "aws_iam_policy_attachment" "ecs_task_execution_policy_attachment" {
  name       = "ecs_task_execution_policy_attachment"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}





