data "aws_availability_zones" "available" {}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.48.0"

  name = "k8s-ipv6"

  cidr = "10.44.0.0/16"

  azs              = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  public_subnets   = ["10.44.101.0/24", "10.44.102.0/24"]

  enable_nat_gateway = true

  enable_ipv6                     = true
  assign_ipv6_address_on_creation = true

  private_subnet_assign_ipv6_address_on_creation = false

  public_subnet_ipv6_prefixes   = [0, 1]

  tags = {
    Terraform   = "true"
    Type        = "ipv6"
    Environment = "dev"
  }

}
