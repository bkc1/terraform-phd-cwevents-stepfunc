# Terraform - Auto Stop/Start EC2 upon retirement notification with Cloudwatch Events & Step Functions 


## Overview 

This Terraform example deploys the resources to automatically stop/start an EC2 instance that gets flagged in Personal Health Dashboard for retirement. The stop/start moves the instance to a new, healthy underlying host. This can be done much easier using AWS Systems Manager(SSM) automation, but this shows a simple example of how Lambda & Step Functions can be utilized as an alternative. 

Terraform creates a test EC2 instance and populates a local test json payload file on the local machine. This payload can be used to test Lambda and the Step Function execution as noted below.

In addtion, Terraform will zip up the python source before deploying the Lambda functions.

## Prereqs & Dependencies

Create SSH keys in the keys directory

```sh
ssh-keygen -t rsa -f ./keys/mykey -N ""
```


## Usage 

Invoking Lambdas with test PHD JSON payload:
```
$ aws lambda invoke --invocation-type RequestResponse --function-name EC2stop --region us-west-1 --payload file://test-PHD-EC2-retirement.json
$ aws lambda invoke --invocation-type RequestResponse --function-name EC2start --region us-west-1 --payload file://test-PHD-EC2-retirement.json 
```

Start Stepfunction execution:
```
$ aws stepfunctions start-execution --state-machine-arn  arn:aws:states:us-west-1:692393258246:stateMachine:demo1-dev-stop-start-instances  --input file://test-PHD-EC2-retirement.json --region us-west-1
```
