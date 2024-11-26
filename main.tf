
#le provider AWS 

provider "aws" {
  region = var.aws_region
}

 #repository ECR

resource "aws_ecr_repository" "users-repo-yasm" {
    name = var.ecr_repo
    image_tag_mutability = "MUTABLE"

    tags = {
        ENV     = var.environment
        Project = "fplarache-smartlib-user"
        Owner   = "yassine ait si mbarek"
      }
}

#cluster ECS

resource "aws_ecs_cluster" "users-cluster-yasm" {
  name = var.ecs_cluster

  tags = {
          ENV     = var.environment
          Project = "fplarache-smartlib-user"
          Owner   = "YASSINE AIT SI M'BAREK"
        }
}

 #définition de tâche ECS -  task definition ECS

resource "aws_ecs_task_definition" "users-taskd-yasm" {
    family = var.ecs_task_family
    container_definitions = <<DEFINITION
    [
        {
            "name":"users-yasm-container",
            "image":"${aws_ecr_repository.users-repo-yasm.repository_url}:latest", 
            "memory":512,
            "cpu": 256,
            "essential":true
        }
    ]
    DEFINITION
    requires_compatibilities = ["FARGATE"]
    network_mode             = "awsvpc"
    memory                   = "512"
    cpu                      = "256"
    execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn     //Associer le rôle IAM à votre définition de tâche ECS
 
}


#service ECS

resource "aws_ecs_service" "users-fgservice-yasm" {
  name            = var.ecs_service
  cluster         = aws_ecs_cluster.users-cluster-yasm.id
  task_definition = aws_ecs_task_definition.users-taskd-yasm.arn
  launch_type  = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets = var.subnet_ids
    assign_public_ip = true
  }

  tags = {
            ENV     = var.environment
            Project = "fplarache-smartlib-user"
            Owner   = "YASSINE AIT SI M'BAREK"
          }
}


#le rôle IAM pour ECS

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role_yasm"

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

  tags = {
            ENV     = var.environment
            Project = "fplarache-smartlib-user"
            Owner   = "YASSINE AIT SI M'BAREK"
          }
}

#l'ajoutez des politiques au rôle

resource "aws_iam_policy_attachment" "ecs_task_execution_policy_attachment" {
  name       = "ecs_task_execution_policy_attachment"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}





