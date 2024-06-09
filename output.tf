output "certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "bastion-server" { value = module.bastion.bastion-publicIP }

output "jenkins-contrl-server" { value = module.jenkins.jenkins-contrl-ip }

output "jenkins-agent-server" { value = module.jenkins.jenkins-agent-ip }

output "sonar-server" { value = module.sonarqube.sonar-server }

output "rds-endpoint" { value = module.rds.rds-endpoint }

output "rds-address" { value = module.rds.rds-address }




# terraform apply -var-file="-stage.tfvars" -auto-approve
