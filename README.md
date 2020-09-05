# IPV6 Kubernetes on AWS

### Description
This project automates IPV6 Kubernetes cluster creation on AWS in just one simple command `terraform apply`. It creates all the required stuff to be ipv6 operational on AWS and also deploys full ipv6 kuberentes on EC2 instances without DualStack.

### Dependencies
You need to install following tools to use this terraform project:
- terraform (lastest)
- ansible (latest)

### Usage
- Generate ssh key-pair for EC2 instances: `mkdir ./ansible/ssh/ && ssh-keygen -t rsa -b 2048 -C "k8s" -f ./ansible/ssh/k8s`
- Run terraform: `terraform init && terraform apply`

### Author
Irakli Korpashvili
