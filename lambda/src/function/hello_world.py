import json
import os
from src.layer.base.datetime_jp import now


def lambda_handler(event, context):
    messgae = f"Hello from Lambda with {os.environ.get('AWS_LAMBDA_FUNCTION_ALIAS')} alias! The current local time is {now()} !"
    return {
        'statusCode': 200,
        'body': messgae
    }
