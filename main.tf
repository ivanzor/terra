resource "aws_instance" "instance" {
  ami             = "${data.aws_ami.ubuntu.id}"
  instance_type   = "t3.micro"
  tags = {
   Name = "web"
 }
}
