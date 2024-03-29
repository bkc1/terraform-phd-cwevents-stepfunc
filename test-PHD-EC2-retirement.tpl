{
  "id": "00fdef86-e930-cc2a-3bf7-1fd61ab3c89f",
  "time": "2018-11-01T22:00:00Z",
  "detail": {
    "endTime": "Thu, 1 Nov 2018 22:00:00 GMT",
    "service": "EC2",
    "eventArn": "arn:aws:health:us-east-1::event/EC2/AWS_EC2_PERSISTENT_INSTANCE_RETIREMENT_SCHEDULED/AWS_EC2_PERSISTENT_INSTANCE_RETIREMENT_SCHEDULED3d776ac7-512d-4a3b-8ea4-73c33993a906",
    "startTime": "Thu, 1 Nov 2018 22:00:00 GMT",
    "eventTypeCode": "AWS_EC2_PERSISTENT_INSTANCE_RETIREMENT_SCHEDULED",
    "affectedEntities": [
      {
        "tags": {},
        "entityValue": "${instance_id}"
      }
    ],
    "eventDescription": [
      {
        "language": "en_US",
        "latestDescription": "EC2 has detected degradation of the underlying hardware hosting your Amazon EC2 instance associated with this event in the us-east-1 region. Due to this degradation, your instance could already be unreachable. After 2018-11-01 22:00 UTC your instance, which has an EBS volume as the root device, will be stopped.\\n \\nYou can see more information on your instances that are scheduled for retirement in the AWS Management Console (https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#Events)\\n \\n* How does this affect you?\\n \\nYour instance will be stopped after the specified retirement date, but you can start it again at any time. Note that if you have EC2 instance store volumes attached to the instance, any data on these volumes will be lost when the instance is stopped or terminated as these volumes are physically attached to the host computer\\n \\n* What do you need to do?\\n \\nYou can wait for the scheduled retirement date - when the instance is stopped - or stop the instance yourself any time before then. Once the instances has been stopped, you can start the instance again at any time. For more information about stopping and starting your instance, and what to expect when your instance is stopped, such as the effect on public, private and Elastic IP addresses associated with your instance, see Stop and Start Your Instance in the EC2 User Guide (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Stop_Start.html).\\n \\n* Why retirement?\\n \\nAWS may schedule instances for retirement in cases where there is an unrecoverable issue with the underlying hardware. For more information about scheduled retirement events please see the EC2 user guide (http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-retirement.html).\\n \\nIf you have any questions or concerns, you can contact the AWS Support Team on the community forums and via AWS Premium Support at: http://aws.amazon.com/support"
      }
    ],
    "eventTypeCategory": "scheduledChange"
  },
  "region": "${region}",
  "source": "aws.health",
  "account": "${account_id}",
  "version": "0",
  "resources": [
    "${instance_id}"
  ],
  "detail-type": "AWS Health Event"
}
