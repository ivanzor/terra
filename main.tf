resource "aws_instance" "instance" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t3.micro"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  key_name         = "${aws_key_pair.devops.id}"
  associate_public_ip_address = true

  provisioner "remote-exec" {
   inline = [
   "sudo apt update -y",
   "sudo apt install nginx -y",
   "sudo service nginx start"
   ]
  } 
  
  connection {
    host     = "${aws_instance.instance.public_ip}"
    type     = "ssh"
    user     = "ubuntu"
    password = ""
    private_key = file("~/.ssh/id_rsa")
  } 
  
  tags = {
   Name = "web"
 }
}

resource "aws_key_pair" "devops" {
  key_name   = "devops"
  public_key = file("~/.ssh/id_rsa.pub")
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
   ingress {
    from_port = 22
    to_port = 22
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

