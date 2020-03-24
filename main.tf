provider "aws" {
  access_key = ""
  secret_key = ""
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "ec2-example" {
   instance_type    = "t2.micro"
   ami              = "ami-0ce21b51cb31a48b8"
   #nombre de la instancia que se creara
   tags = {
     Name = "HolaMundo"
   }

   vpc_security_group_ids = [aws_security_group.demo.id]

   user_data = <<-EOF
             #!/bin/bash
             sudo amazon-linux-extras install nginx1.12 -y
             sudo service nginx start
             EOF
}

resource "aws_security_group" "demo" {
  name = "demo-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}





