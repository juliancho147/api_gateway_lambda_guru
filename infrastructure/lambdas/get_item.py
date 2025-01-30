import json
import boto3
import traceback
from decimal import Decimal


def decimal_default(obj):
    if isinstance(obj, Decimal):
        return int(obj)
    raise TypeError


dynamodb = boto3.resource("dynamodb")
table_name = "ClothesItems"
table = dynamodb.Table(table_name)


def lambda_handler(event, context):
    """get a specific item

    Args:
        event (dict): event
        context (none): none

    Returns:
        json: response
    """
    try:
        query_params = json.loads(event.get('body', '{}'))
        partition_key = query_params.get("Id")
        sort_key = query_params.get("Name")
        if partition_key and sort_key:
            response = table.get_item(Key={"Id": partition_key, "Name": sort_key})
            item = response.get("Item")
            if not item:
                return {
                    "statusCode": 404,
                    "body": json.dumps({"message": "Item no encontrado"}),
                }
            return {"statusCode": 200, "body": json.dumps(item, default=decimal_default)}
        else:
            response = table.scan()
            items = response.get('Items', [])
            return {
                'statusCode': 200,
                'body': json.dumps({'items': items}, default=decimal_default)
            }
    except Exception as e:
        error_trace = traceback.format_exc()
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e), "traceback": error_trace}),
        }
