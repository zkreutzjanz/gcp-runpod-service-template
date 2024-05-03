# imports
import os
import main 
import tempfile
import uuid
import json


# # Simple way to setup GCS client access
# from google.cloud import storage
# import google.auth
# creds_json = os.environ.get("GCS_CREDENTIALS")
# if not creds_json:
#     exit("GCS_CREDENTIALS not set")
# credentials, _ = google.auth.load_credentials_from_dict(json.loads(creds_json))
# storage_client = storage.Client(credentials=credentials)
# RUNPOD_BUCKET = os.environ.get("RUNPOD_BUCKET")

# GCS uploading and downloading
# def download_from_gcs(bucket_name, file_path, destination_path):
#     bucket = storage_client.get_bucket(bucket_name)
#     blob = bucket.blob(file_path)
#     blob.download_to_filename(destination_path)
# def upload_to_gcs(bucket_name, file_path, destination_path):
#     bucket = storage_client.get_bucket(bucket_name)
#     blob = bucket.blob(destination_path)
#     blob.upload_from_filename(file_path)
    
   
    
def handler(event):

  ## get the input data
  input_data = event['input']
 
  ## return the output
  return input_data
    

import runpod
runpod.serverless.start({
    "handler": handler,
})

