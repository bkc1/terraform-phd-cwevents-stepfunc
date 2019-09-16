{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "logs:CreateLogGroup"
            ],
            "Resource": [
                "arn:aws:logs:us-west-2:${account_id}:log-group:/aws/lambda/${start_function}:*",
                "arn:aws:logs:us-west-2:${account_id}:log-group:/aws/lambda/${stop_function}:*"
            ]
        } 
    ]
}
