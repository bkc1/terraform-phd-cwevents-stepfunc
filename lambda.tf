
data "archive_file" "lambda_zip1" {
  type        = "zip"
  source_dir  = "${path.root}/lambda/stopec2/"
  output_path = "${path.root}/stopec2.zip"
}

data "archive_file" "lambda_zip2" {
  type        = "zip"
  source_dir  = "${path.root}/lambda/startec2/"
  output_path = "${path.root}/startec2.zip"
}

resource "aws_lambda_function" "stop_lambda" {
  filename         = "stopec2.zip"
  function_name    = "${var.stop_lambda_name}"
  role             = "${aws_iam_role.lambda.arn}"
  handler          = "stopec2.lambda_handler"
  source_code_hash = "${data.archive_file.lambda_zip1.output_base64sha256}"
  runtime          = "python2.7"
  timeout          = 12

  environment {
    variables = {
      foo = "${var.app_prefix}-${var.env}"
    }
  }
}

resource "aws_lambda_function" "start_lambda" {
  filename         = "startec2.zip"
  function_name    = "${var.start_lambda_name}"
  role             = "${aws_iam_role.lambda.arn}"
  handler          = "startec2.lambda_handler"
  source_code_hash = "${data.archive_file.lambda_zip2.output_base64sha256}"
  runtime          = "python2.7"
  timeout          = 12

  environment {
    variables = {
      foo = "${var.app_prefix}-${var.env}"
    }
  }
}
