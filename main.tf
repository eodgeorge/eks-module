module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "vpc"

  azs             = data.aws_availability_zones.azs.names
  cidr            = var.cidr
  private_subnets = var.private_subnets_cidr_blocks
  public_subnets  = var.public_subnets_cidr_blocks

  create_database_nat_gateway_route = true
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_vpn_gateway = true

  tags = {
    "k8s-cluster" = "vpc"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.13.0"

  cluster_name    = "eks-cluster"
  cluster_version = "1.29"
  

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets

cluster_security_group_additional_rules = {
  "bastion_rule" = {
    description              = "Access EKS from Bastion host."
    protocol                 = "tcp"
    from_port                = 443
    to_port                  = 443
    type                     = "ingress"
    source_security_group_id = module.sg.Bastion_SG-id
  }
  "jenkins_rule" = {
    description              = "Access EKS from Jenkins controller."
    protocol                 = "tcp"
    from_port                = 443
    to_port                  = 443
    type                     = "ingress"
    source_security_group_id = module.sg.jenkins-sg-id
  }
}


  eks_managed_node_groups = {
    example = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t2.medium"]
    }
  }
}

module "eks-blueprints-addons" {
  source  = "aws-ia/eks-blueprints-addons/aws"
  version = "1.16.3"
  
  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn

  eks_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
    coredns = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
  }

  enable_aws_load_balancer_controller    = true
  enable_kube_prometheus_stack           = true
  enable_metrics_server                  = true
  enable_external_dns                    = true
  enable_argocd                          = true
  enable_ingress_nginx                   = true
  enable_cluster_autoscaler              = true

  tags = {
    "k8s-cluster" = "add-ons"
  }
}

module "bastion" {
 source           = "./bastion"
 ami              = module.keypair.eks-ami-id
 bastion-SG       = module.sg.Bastion_SG-id
 key_name         = module.keypair.public-key
 public-subnet    = module.vpc.public_subnets [0]
 prv-key          = module.keypair.private-key
 kubeconfig       = local.kubeconfig  
 access-key       = module.iam.access-key
 secret-key       = module.iam.secret-key

}

module "jenkins" {
 source               = "./jenkins"
 ami                  = module.keypair.eks-ami-id
 jenkins-SG           = module.sg.jenkins-sg-id
 key_name             = module.keypair.public-key
 private-subnet       = module.vpc.private_subnets [0]
 agent_ip             = module.jenkins.jenkins-agent-ip
 kubeconfig           = local.kubeconfig  
 access-key           = module.iam.access-key
 secret-key           = module.iam.secret-key
}

module "rds" {
 source                   = "./rds"
 password                 = "petclinic"
 username                 = "petclinic"
 rds-SG                   = module.sg.rds_SG-id
 private-subnet           = module.vpc.private_subnets [0]
}

module "sg" {
 source                   = "./sg"
 vpc                      = module.vpc.vpc_id
}

module "keypair" {
 source                   = "./keypair"
}

module "iam" {
 source                   = "./iam"
}


module "sonarqube" {
 source                   = "./sonarqube"
 ami                      = module.keypair.eks-ami-id
 sonarqube-SG             = module.sg.Sonarqube_SG-id
 key_name                 = module.keypair.public-key
 public-subnet            = module.vpc.private_subnets [0]
}


