resource "aws_key_pair" "key" {
  key_name   = "k8s-key"
  public_key = file("${path.module}/ansible/ssh/k8s.pub")
}

resource "aws_security_group" "sg" {
  name        = "k8s-sg"
  description = "k8s-sg"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "k8s"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "k8s-sg" 
    Terraform   = "true"
    Environment = "dev"
  }
}

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.15.0"

  name                   = "k8s"
  instance_count         = 3
  ami                    = "ami-0d4002a13019b7703"
  instance_type          = "t3a.large"
  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = module.vpc.public_subnets[0]
  source_dest_check      = false
  user_data_base64       = base64encode(local.user_data)

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

}
