import json


def lambda_handler(event, context):
    """_summary_

    Args:
        event (dic): _description_
        context (dic): _description_

    Returns:
        _type_: _description_
    """
    print(event)
    return {
        'statusCode': 200,
        'body': json.dumps(f'{event}')
    }
