resource "aws_cloudwatch_metric_alarm" "cpu-utilization" {
  count               = "${var.Count}"
  alarm_name          = "high-cpu-util-alarm-${element(aws_instance.my-test-instance.*.id, count.index)}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"
  alarm_description   = "This metric monitors ec2 cpu utilization"
#  alarm_actions       = ["${var.sns_topic}"]

  dimensions = {
     InstanceId = "${element(aws_instance.my-test-instance.*.id, count.index)}"
  }
}

