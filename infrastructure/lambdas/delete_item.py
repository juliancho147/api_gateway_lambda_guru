import json
import boto3
import traceback


dynamodb = boto3.resource("dynamodb")
table_name = "ClothesItems"
table = dynamodb.Table(table_name)


def lambda_handler(event, context):
    """delete item

    Args:
        event (_type_): _description_
        context (_type_): _description_

    Returns:
        _type_: _description_
    """
    try:
        query_params = json.loads(event["body"])
        partition_key = query_params["Id"]
        sort_key = query_params["Name"]
        response = table.delete_item(Key={"Id": partition_key, "Name": sort_key})
        return {
            "statusCode": 200,
            "body": json.dumps(
                {"message": f"Item eliminado correctamente: {response}"}
            ),
        }
    except Exception as e:
        error_trace = traceback.format_exc()
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e), "traceback": error_trace}),
        }
