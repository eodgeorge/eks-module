# output "certificate_authority_data" {
#   value = module.eks.cluster_certificate_authority_data
# }

output "cluster_name" {
  value = module.eks.cluster_name
}

# output "cluster_endpoint" {
#   value = module.eks.cluster_endpoint
# }

output "bastion-server" { value = module.bastion.bastion-publicIP }

output "jenkins-contrl-server" { value = module.jenkins.jenkins-contrl-ip }

output "jenkins-agent-server" { value = module.jenkins.jenkins-agent-ip }

output "sonar-server" { value = module.sonarqube.sonar-server }

output "rds-endpoint" { value = module.rds.rds-endpoint }

output "rds-address" { value = module.rds.rds-address }




# terraform apply -var-file=stage.tfvars -auto-approve
# kubectl create secret generic mysql-secret --type=opaque 
# --from-literal=MYSQL_ROOT_PASSWORD=secrets --from-literal=MYSQL_DATABASE=petclinic 
# --from-literal=MYSQL_USER=petclinic --from-literal=MYSQL_PASSWORD=p[Betclinic --dry-run=client -o yaml 
#  kubectl port-forward service/phpmyadmin --address 0.0.0.0 8092:80
#   echo c2VjcmV0cw== | base64 -d    echo -n petclinic | base64


# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   name: phpmyadmin
#   labels:
#     app: phpmyadmin
# spec:
#   replicas: 1
#   selector:
#     matchLabels:
#       app: phpmyadmin
#   template:
#     metadata:
#       labels:
#         app: phpmyadmin
#     spec:
#       containers:
#       - name: phpmyadmin
#         image: phpmyadmin/phpmyadmin:latest
#         ports:
#         - containerPort: 80
#         env:
#         - name: PMA_HOST
#           value: mysql-service   # MySQL host
#         - name: PMA_PORT
#           value: "3306"          # MySQL port
#         - name: PMA_USER
#           value: "your_mysql_username"   # MySQL username
#         - name: PMA_PASSWORD
#           valueFrom:
#             secretKeyRef:
#               name: mysql-secret    # Name of the Secret containing MySQL password
#               key: MYSQL_PASSWORD  # Key in the Secret containing MySQL password
#         - name: PMA_DB_NAME
#           value: "your_database_name"    # MySQL database name



   
