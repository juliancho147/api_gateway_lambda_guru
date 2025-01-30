import json
import boto3


dynamodb = boto3.resource('dynamodb')
table_name = "ClothesItems"  # Definir la tabla en variables de entorno
table = dynamodb.Table(table_name)


def lambda_handler(event, context):
    """_summary_

    Args:
        event (_type_): _description_
        context (_type_): _description_

    Returns:
        _type_: _description_
    """
    try:
        # Suponemos que el evento contiene un objeto JSON con los datos a insertar
        item = json.loads(event['body'])
        # Insertar el item en la tabla
        table.put_item(Item=item)
        return {
            'statusCode': 200,
            'body': json.dumps({'message': 'Item insertado correctamente'})
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
