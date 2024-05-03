# What is this?
This is a template repository for creating a runpod service that works on both pods and serverless.

# What is required?
1. Google cloud sdk installed
2. Google cloud project created
3. Google cloud build enabled
4. Google cloud build given necessary permissions
5. Dockerhub account created
6. Dockerhub repository created
7. Runpod account created
8. Runpod docker credentials created


# How To Use 
1. Use this repository as a template to create a new repository
2. Modify your handler.js file with your function code
3. Copy in any other needed runtime files
4. Create your deployment triggers
  - For each active branch/environment you have a trigger-<env>.yaml file
  - Replace "runpod-service-template" with your service name everywhere
  - For the github area, replace needed vals
  - deploy via deploy-trigger.bat <triggerfile>
5. Create secrets/configs
  - only use secrets for this project, configs are non-sensitive runtime vars
  - For each secret you have a <secretname>-secret.secret file and put in value
  - deploy via deploy-config.bat <secretfile> <secretname>  (like deploy-config.bat ivt-docker-password-secret-dev-secret.secret ivt-docker-password-secret-dev)
6. Add your repo to cloud build repo list v1

```
NOTE: I incredibly dislike the use of batch files, but I have not found a better way to deploy the trigger and config files. Using bash scripts would be better, but recent changes to the GCP SDK have an issue with the gcloud command in bash scripts.
```

