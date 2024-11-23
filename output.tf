
output "ecr_repository_url" {
  value = aws_ecr_repository.dev-fplarache-smartlib-users-repo-yasm.repository_url
}

output "ecs_cluster_id"{
    value = aws_ecs_cluster.dev-fplarache-smartlib-users-fgcluster-yasm.id
}
