import json
import boto3
import os
import time
import http_responses.responses as responses
from http import HTTPStatus

s3 = boto3.client('s3')

def list_objects(cli, bucket, prefix):
    extraArgs = {'Bucket': bucket,'Prefix': prefix}
    while True:
        resp = cli.list_objects_v2(**extraArgs)
        yield from resp['Contents']

        if not 'ContinuationToken' in resp:
            break

        extraArgs['ContinuationToken'] = resp['ContinuationToken']


def lambda_handler(event, context):
    print(event)
    bucket = 'portfolio-assets'
    prefix = 'templates-1'
    try:
        s3_objects = []

        for row in list_objects(s3, bucket, prefix):
            if row['Key'] == 'templates-1/':
                pass
            else:
                s3_objects.append(row['Key'])

        response = {}
        response['s3_keys'] = s3_objects

        return responses.generate_response(response, HTTPStatus.OK)
    except Exception as inst:
      return responses.generate_error_response(inst, HTTPStatus.BAD_REQUEST)