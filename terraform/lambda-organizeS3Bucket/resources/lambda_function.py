import boto3
import os
from datetime import datetime

today = datetime.today()
today_formated = today.strftime("%d%m%Y") #format to ddmmyyyy

def lambda_handler(event, context):
    
    s3_client = boto3.client("s3")

    bucket_name = os.environ['S3_BUCKET_NAME'] #Dynamic set bucket name 
    list_object_response = s3_client.list_objects_v2(Bucket=bucket_name) #list all obj in s3 bucket

    get_contents = list_object_response.get("Contents") #ggget only contents in returned dictionary 

    get_all_s3_object_and_folder_names = []

    for item in get_contents:
        s3_object_name = item.get("Key")
        get_all_s3_object_and_folder_names.append(s3_object_name)

    directory_name = today_formated + "/"

    if directory_name not in get_all_s3_object_and_folder_names:
        s3_client.put_object(Bucket=bucket_name, Key=(directory_name))

    for item in get_contents:
        object_creation_date = item.get("LastModified").strftime("%d%m%Y") + "/"
        object_name = item.get("Key")

        if object_creation_date == directory_name and "/" not in object_name:
            s3_client.copy_object(Bucket=bucket_name, CopySource=bucket_name+"/"+object_name, Key=directory_name+object_name)
            s3_client.delete_object(Bucket=bucket_name,Key=object_name)