import boto3

def lambda_handler(event, context):
  region = event['region']
  instances = event['detail']['affectedEntities'][0]['entityValue']
  ec2 = boto3.client('ec2', region_name=region)
  ec2.stop_instances(InstanceIds=[instances])
  print 'stopped your instances: ' + str(instances)
