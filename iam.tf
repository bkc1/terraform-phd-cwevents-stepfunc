#IAM

resource "aws_iam_role" "stepfunction" {
  name               = "${var.app_prefix}-${var.env}-${var.aws_region}-StepFunction"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": ["states.amazonaws.com"]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role" "cwevent" {
  name               = "${var.app_prefix}-${var.env}-${var.aws_region}-CWevents"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": ["events.amazonaws.com"]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role" "lambda" {
  name               = "${var.app_prefix}-${var.env}-${var.aws_region}-LambdaServiceRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "stepfunction" {
  name   = "${var.app_prefix}-${var.env}-${var.aws_region}-stepfunction"
  role   = "${aws_iam_role.stepfunction.id}"
  policy = "${data.template_file.iam_sfn.rendered}"
}

resource "aws_iam_role_policy" "lambda_exec" {
  name   = "${var.app_prefix}-${var.env}-${var.aws_region}-lambda-exec"
  role   = "${aws_iam_role.lambda.id}"
  policy = "${data.template_file.iam_lambda.rendered}"
}

resource "aws_iam_role_policy" "cwevent_sfn" {
  name   = "${var.app_prefix}-${var.env}-${var.aws_region}-CW-event"
  role   = "${aws_iam_role.cwevent.id}"
  policy = "${data.template_file.iam_cw.rendered}"
}

resource "aws_iam_policy" "lambda_ec2" {
  name   = "${var.app_prefix}-${var.env}-${var.aws_region}-lambda-ec2"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "ec2:*",
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_exec" {
  role       = "${aws_iam_role.lambda.name}"
  policy_arn = "${aws_iam_policy.lambda_ec2.arn}"
}

resource "aws_iam_role_policy_attachment" "logs_policy" {
    role       = "${aws_iam_role.lambda.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

data "template_file" "iam_sfn" {
  template = "${file("stepfunction_policy.tpl")}"
  vars = {
    start_function      = "${aws_lambda_function.start_lambda.arn}"
    stop_function       = "${aws_lambda_function.stop_lambda.arn}"
  }
}

data "template_file" "iam_lambda" {
  template = "${file("lambdaexec_policy.tpl")}"
  vars = {
    start_function      = "${var.start_lambda_name}"
    stop_function       = "${var.start_lambda_name}"
    account_id          = "${data.aws_caller_identity.current.account_id}"	
  }
}

data "template_file" "iam_cw" {
  template = "${file("CWevent_sfn_policy.tpl")}"
  vars = {
    stepfunction_arn       = "${aws_sfn_state_machine.stopstartlambda.id}"
  }
}
