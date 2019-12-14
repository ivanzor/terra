resource "aws_instance" "instance" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t3.micro"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]

  tags = {
   Name = "web"
 }
}

resource "aws_security_group" "web" {
  name = "Web Security Group"
  description = "Security group"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   tags = {
     Name = "Web"
 }
}

