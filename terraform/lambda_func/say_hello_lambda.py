import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def in_japanese(event, context):
    logger.info(event)  
    return {"body": "こんにちわ from lambda", "Status": 200}    


def lambda_handler(event, context):
    logger.info(event)  
    return {"body": "hello from lambda", "Status": 200}    
