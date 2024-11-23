
output "ecr_repository_url" {
  value = aws_ecr_repository.users-repo-yasm.repository_url
}

output "ecs_cluster_id"{
    value = aws_ecs_cluster.users-cluster-yasm.id
}

output "ecs_service" {
    value = aws_ecs_service.users-fgservice-yasm.name
}