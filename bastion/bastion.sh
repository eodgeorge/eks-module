  #!/bin/bash
  echo "pubkeyAcceptedkeyTypes=+ssh-rsa" | sudo tee -a /etc/ssh/sshd_config.d/10-insecure-rsa-keysig.conf
  systemctl reload sshd
  echo "${prv-key}" >> /home/ubuntu/.ssh/id_rsa
  chown -R ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa
  chmod 400 /home/ubuntu/.ssh/id_rsa
  sudo mkdir /home/ubuntu/.kube
  echo "${kubeconfig}" >> /home/ubuntu/.kube/config
  sudo apt install unzip
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  sudo ln -svf /usr/local/bin/aws /usr/bin/aws
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.15.10/2020-02-22/bin/linux/amd64/aws-iam-authenticator
  chmod +x ./aws-iam-authenticator
  sudo mv ./aws-iam-authenticator /usr/local/bin
  sudo su -c "aws configure set aws_access_key_id ${access-key}" ubuntu
  sudo su -c "aws configure set aws_secret_access_key ${secret-key}" ubuntu
  sudo su -c "aws configure set default.region eu-west-2" ubuntu
  sudo su -c "aws configure set default.output text" ubuntu
  ARCH=amd64
  PLATFORM=$(uname -s)_$ARCH
  curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"
  tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz
  sudo mv /tmp/eksctl /usr/local/bin
  sudo snap install helm --classic
  sudo su -c "helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx" ubuntu
  sudo su -c "helm repo update" ubuntu
  sudo hostnamectl set-hostname Bastion