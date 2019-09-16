resource "aws_sfn_state_machine" "stopstartlambda" {
  name     = "${var.app_prefix}-${var.env}-stop-start-instances"
  role_arn = "${aws_iam_role.stepfunction.arn}"

  definition = "${data.template_file.sfn.rendered}"
}

data "template_file" "sfn" {
  template = "${file("sfn.definition.tpl")}"
  vars = {
    start_function      = "${aws_lambda_function.start_lambda.arn}"
    stop_function       = "${aws_lambda_function.stop_lambda.arn}"
  }
}
