# ---
# apiVersion: v1
# data:
#   MYSQL_DATABASE: petclinic
# kind: ConfigMap
# metadata:
#   creationTimestamp: null
#   name: db-config
# ---
# apiVersion: v1
# data:
#   MYSQL_PASSWORD: cGV0Y2xpbmlj
#   MYSQL_USER: cGV0Y2xpbmlj
#   MYSQL_ROOT_PASSWORD: c2VjcmV0cw==
# kind: Secret
# metadata:
#   creationTimestamp: null
#   name: db-secret
# ---
# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   creationTimestamp: null
#   labels:
#     app: mysql-dep
#   name: mysql-dep
# spec:
#   replicas: 1
#   selector:
#     matchLabels:
#       app: mysql-dep
#   strategy: {}
#   template:
#     metadata:
#       creationTimestamp: null
#       labels:
#         app: mysql-dep
#     spec:
#       containers:
#       - image: mysql
#         name: mysql
#         envFrom:
#         - configMapRef:
#             name: db-config
#         - secretRef:
#             name: db-secret
#         resources: {}
# status: {}
# ---
# apiVersion: v1
# data:
#   PMA_HOST: mysql-svc
#   PMA_PORT: "3306"
# kind: ConfigMap
# metadata:
#   creationTimestamp: null
#   name: php-config

# # ---
# apiVersion: v1
# data:
#   PMA_HOST: mysql-rdds.cvywsycko4uh.eu-west-2.rds.amazonaws.com
#   PMA_PORT: "3306"
# kind: ConfigMap
# metadata:
#   creationTimestamp: null
#   name: php-config

# ---

# apiVersion: v1
# data:
#   PMA_PASSWORD: cGV0Y2xpbmlj
#   PMA_USER: cGV0Y2xpbmlj
#   MYSQL_ROOT_PASSWORD: c2VjcmV0cw==
# kind: Secret
# metadata:
#   creationTimestamp: null
#   name: php-secret
# ---

# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   creationTimestamp: null
#   labels:
#     app: phpmyadmin
#   name: phpmyadmin
# spec:
#   replicas: 1
#   selector:
#     matchLabels:
#       app: phpmyadmin
#   strategy: {}
#   template:
#     metadata:
#       creationTimestamp: null
#       labels:
#         app: phpmyadmin
#     spec:
#       containers:
#       - image: phpmyadmin
#         name: phpmyadmin
#         envFrom:
#         - configMapRef:
#             name: php-config
#         - secretRef:
#             name: php-secret
#         resources: {}
# status: {}
# ---
# apiVersion: v1
# kind: Service
# metadata:
#   name: phpmyadmin-svc
# spec:
#   ports:
#     - port: 8000
#       targetPort: 80
#   selector:
#     app: phpmyadmin

# # ---
# # apiVersion: v1
# # data:
# #   MYSQL_DATABASE: Petclinic
# #   MYSQL_URL: jdbc:mysql://mysql-rdds.cvywsycko4uh.eu-west-2.rds.amazonaws.com:3306/petclinic
# # kind: ConfigMap
# # metadata:
# #   creationTimestamp: null
# #   name: db-config


# # ---
# apiVersion: v1
# data:
#   MYSQL_DATABASE: petclinic
#   MYSQL_URL: jdbc:mysql://mysql-rdds.cvywsycko4uh.eu-west-2.rds.amazonaws.com:3306/petclinic
# kind: ConfigMap
# metadata:
#   creationTimestamp: null
#   name: db-config
# ---
# apiVersion: v1
# data:
#   MYSQL_PASS: cGV0Y2xpbmlj
#   MYSQL_USER: cGV0Y2xpbmlj
#   MYSQL_ROOT_PASSWORD: c2VjcmV0cw==
# kind: Secret
# metadata:
#   creationTimestamp: null
#   name: db-secret
# ---
# apiVersion: v1
# data:
#   .dockerconfigjson: eyJhdXRocyI6eyJodHRwczovL2luZGV4LmRvY2tlci5pby92MS8iOnsidXNlcm5hbWUiOiJlb2RnZW9yZ2UiLCJwYXNzd29yZCI6IldlbmdlcjEyMzQ1QCIsImF1dGgiOiJaVzlrWjJWdmNtZGxPbGRsYm1kbGNqRXlNelExUUE9PSJ9fX0=
# kind: Secret
# metadata:
#   creationTimestamp: null
#   name: balde
# type: kubernetes.io/dockerconfigjson
# ---
# apiVersion: apps/v1
# kind: Deployment
# metadata:
#   creationTimestamp: null
#   labels:
#     app: web-app
#   name: web-app
# spec:
#   replicas: 1
#   selector:
#     matchLabels:
#       app: web-app
#   strategy: {}
#   template:
#     metadata:
#       creationTimestamp: null
#       labels:
#         app: web-app
#     spec:
#       imagePullSecrets:
#       - name: balde
#       containers:
#       - image: eodgeorge/balde:balde-v1.0
#         name: balde
#         ports:
#         - containerPort: 8080
#         envFrom:
#         - configMapRef:
#             name: db-config
#         - secretRef:
#             name: db-secret
#         resources: {}
# status: {}
# ---
# apiVersion: v1
# kind: Service
# metadata:
#   name: nginx-svc
# spec:
#   ports:
#     - port: 80
#       targetPort: 8080
#   selector:
#     app: web-app
#   type: LoadBalancer






# # image in hub MYSQL_PASS




