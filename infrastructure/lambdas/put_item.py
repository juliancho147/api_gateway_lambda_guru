import json
import boto3
import traceback


dynamodb = boto3.resource("dynamodb")
table_name = "ClothesItems"  # Definir la tabla en variables de entorno
table = dynamodb.Table(table_name)


def lambda_handler(event, context):
    """update items

    Args:
        event (dict): event
        context (none): none

    Returns:
        joson: response
    """
    try:
        query_params = json.loads(event["body"])
        partition_key = query_params["Id"]
        sort_key = query_params["Name"]
        response = table.get_item(Key={"Id": partition_key, "Name": sort_key})
        item = response.get("Item")
        if not item:
            return {
                "statusCode": 404,
                "body": json.dumps({"message": "Item no encontrado"}),
            }
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
