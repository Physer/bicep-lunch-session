# Deploying with Bicep

## Intro

The READMEs assume you are using the Azure CLI. Make sure you're logged in and the correct subscription is selected.

## How to

Execute the following commands from the directory in which this README is located.

1. Run `az group create --name $RESOURCE_GROUP_NAME --location $LOCATION`
2. Run `az deployment group create --resource-group $RESOURCE_GROUP_NAME --template-file .\main.bicep`