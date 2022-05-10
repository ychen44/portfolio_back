import json
import boto3
import os
import time
import http_responses.responses as responses
from http import HTTPStatus

sns = boto3.client('sns')

def lambda_handler(event, context):
    print(event)
    try:
      data = json.loads(event['body'])
      first_name = data['firstName']
      last_name = data['lastName']
      email = data['email']
      phone_number = data['phoneNumber']
      message = data['message']

      topic_arn = os.getenv('SNS_TOPIC_ARN')

      message_subject = f"You have an inqury from {first_name} {last_name} "    
      message_body = f"Hello, the following person have an inquiry: \n \n \n Name: {first_name} {last_name} \n Email: {email} \n Phone Number: {phone_number} \n Message: {message} \n \n Please reach out to them at the earliest convenience. \n \n Have a great day!"
      
      response = sns.publish(
      TopicArn= topic_arn,
      Message = message_body,
      Subject= message_subject,
      MessageStructure='string',
      MessageAttributes={
          'string': {
              'DataType': 'String',
              'StringValue': 'string',
          }
      },
      )

      return responses.generate_response(response, HTTPStatus.OK)
    except Exception as inst:
      return responses.generate_error_response(inst, HTTPStatus.BAD_REQUEST)