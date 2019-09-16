resource "aws_cloudwatch_event_rule" "phd_ec2" {
  name        = "${var.app_prefix}-${var.env}-${var.aws_region}-StopStartEC2-PHDretirement"
  description = "Auto stop/start EC2 instances using lamdba Step Function state machine upon CW event PHD EC2 retirement notice"
  event_pattern = <<PATTERN
{
  "source": [
    "aws.health"
  ],
  "detail-type": [
    "AWS Health Event"
  ],
  "detail": {
    "service": [
      "EC2"
    ],
    "eventTypeCategory": [
      "scheduledChange"
    ],
    "eventTypeCode": [
      "AWS_EC2_INSTANCE_RETIREMENT_SCHEDULED"
    ]
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "sfn" {
  rule      = "${aws_cloudwatch_event_rule.phd_ec2.name}"
  role_arn  = "${aws_iam_role.stepfunction.arn}"
  arn       = "${aws_sfn_state_machine.stopstartlambda.id}"
}

# test PHD json payload
data "template_file" "test_PHD_json" {
  template = "${file("test-PHD-EC2-retirement.tpl")}"
  vars = {
    region      = "${var.aws_region}"
    instance_id = "${aws_instance.test1.id}"
    account_id  = "${data.aws_caller_identity.current.account_id}"
  }
}

resource "local_file" "test_PHD_json" {
    content  = "${data.template_file.test_PHD_json.rendered}"
    filename = "./test-PHD-EC2-retirement.json"
}

