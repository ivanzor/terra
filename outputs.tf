output "alb_dns_name" {
  value = "${aws_lb.my-aws-alb.dns_name}"
}

output "alb_target_group_arn" {
  value = "${aws_lb_target_group.my-target-group.arn}"
}

output "private_subnet1" {
  value = "${element(aws_subnet.private_subnet.*.id, 1 )}"
}

output "private_subnet2" {
  value = "${element(aws_subnet.private_subnet.*.id, 2 )}"
}


