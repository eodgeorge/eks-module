provider "aws" {
  region  = local.region
  # profile = "default"
  profile = "gooseaccess"

}

locals {
  region = "eu-west-2"
}

  data "aws_availability_zones" "azs" {
  state = "available"
}

# locals {
#   kubeconfig = file("${path.module}/bastion/kubeconfig.yaml")  # Adjust the path to your kubeconfig file
# }

locals {
  kubeconfig = file("${path.root}/kubeconfig.yaml")  # Adjust the path to your kubeconfig file
}
