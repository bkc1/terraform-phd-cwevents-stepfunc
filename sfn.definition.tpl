{
  "Comment": "A simple AWS Step Functions state machine that stop/starts EC2.",
  "StartAt": "Stop EC2",
  "States": {
    "Stop EC2": {
      "Type": "Task",
      "Resource": "${stop_function}",
      "ResultPath": "$.comment",
      "Next": "Start EC2"
    }, 
    "Start EC2": {
      "Type": "Task",
      "Resource": "${start_function}",
      "Retry": [ {
         "ErrorEquals": ["States.TaskFailed"],
         "IntervalSeconds": 2,
         "MaxAttempts": 5,
         "BackoffRate": 2.0
       } ],
      "End": true
    }
}
}


