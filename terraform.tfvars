
#terraform.tfvars  use pour remplacer les valeurs par défaut si nécessaire.

aws_region         = "eu-north-1"
subnet_ids     = ["subnet-0cf9e8ccfb6fd0f77", "subnet-05fac6b2678b41a37" , "subnet-00d967507df4b0bfb"]

environment = "dev"    #Ajoutez la variable environment


#ecr_repo       = "custom-app-repo"
#ecs_cluster    = "custom-cluster"
#ecs_task_family = "custom-task"
#ecs_service    = "custom-service"
