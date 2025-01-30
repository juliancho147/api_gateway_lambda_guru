import json
import boto3
import traceback


dynamodb = boto3.resource("dynamodb")
table_name = "ClothesItems"
table = dynamodb.Table(table_name)


def lambda_handler(event, context):
    """create new items

    Args:
        event (_type_): _description_
        context (_type_): _description_

    Returns:
        json: response
    """
    try:
        query_params = json.loads(event["body"])
        table.put_item(Item=query_params)
        return {
            "statusCode": 200,
            "body": json.dumps({"message": "Item insertado correctamente"}),
        }
    except Exception as e:
        error_trace = traceback.format_exc()
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e), "traceback": error_trace}),
        }
