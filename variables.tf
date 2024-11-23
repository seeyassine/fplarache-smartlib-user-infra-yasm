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
