locals {
  source_files = [
    "./lambda_func/say_hello_lambda.py",
  ]
}

data "template_file" "t_file" {
  count = "${length(local.source_files)}"
  template = "${file(element(local.source_files, count.index))}"
}

data "archive_file" "zip_function" {
  type = "zip"
  output_path = "./lambda.zip"
  source {
    filename = "${basename(local.source_files[0])}"
    content = "${data.template_file.t_file.0.rendered}"
  }
}


resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "say_hello" {
  filename         = "lambda.zip"
  function_name    = "sayHelloLambda"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "say_hello_lambda.lambda_handler"
  runtime          = "python3.9"
  timeout          = "60"
}

resource "aws_lambda_function" "say_hello_in_japanese" {
  filename         = "lambda.zip"
  function_name    = "sayHelloLambdaInJapanese"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "say_hello_lambda.in_japanese"
  runtime          = "python3.9"
  timeout          = "60"
}