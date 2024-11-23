//Définition des variables

// Région AWS

variable "region" {
  description = "AWS region to deploy resources"
  default = "eu-north-1"
}

// Nom du dépôt ECR

variable "ecr_repo" {
  description = "Name of the ECR repository"
  default     = "dev-fplarache-smartlib-users-repo-yasm"
}

// Nom du cluster ECS

variable "ecs_cluster" {
  description = "Name of the ECS cluster"
  default     = "dev-fplarache-smartlib-users-fgcluster-yasm"
}


# Nom de la famille de la tâche ECS

variable "ecs_task_family" {
  description = "Family name for the ECS task definition"
  default     = "dev-fplarache-smartlib-users-td-yasm"
}


# Nom du service ECS

variable "ecs_service" {
  description = "Name of the ECS service"
  default     = "dev-fplarache-smartlib-users-fgservice-yasm"
}

# Subnet IDs pour ECS

variable "subnet_ids" {
  description = "List of subnet IDs for the ECS service"
  type        = list(string)
  default     = ["subnet-0cf9e8ccfb6fd0f77", "subnet-05fac6b2678b41a37" , "subnet-00d967507df4b0bfb"] 
}