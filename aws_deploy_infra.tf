provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "manage" {
  ami                         = "ami-079db87dc4c10ac91"
  availability_zone           = "us-east-1a"
  instance_type               = "t2.medium"
  key_name                    = "demo"
  subnet_id                   = "subnet-060372cf8cd26124f"
  vpc_security_group_ids      = ["sg-08faf759e7e05c47f"]
  associate_public_ip_address = true
  user_data                   = <<-EOF
    #!/bin/bash
    sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
    sudo yum upgrade -y
    sudo dnf install java-17-amazon-corretto -y
    sudo yum install jenkins -y
    sudo systemctl enable jenkins
    sudo systemctl start jenkins
    sudo yum install git -y
    sudo yum install docker -y
    sudo usermod -a -G docker ec2-user
    sudo yum install python3-pip
    sudo systemctl enable docker.service
    sudo systemctl start docker.service
    EOF
  tags = {
    Name = "Dmanage"
  }
}
