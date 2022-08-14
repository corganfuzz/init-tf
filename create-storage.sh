#! /bin/bash

RESOURCE_GROUP_NAME="eastTwo"
STORAGE_ACCOUNT_NAME="tfxstateacctwo"
CONTAINER_NAME="tfxstatecont"

function create_resource_group() {
    az group create --name "$RESOURCE_GROUP_NAME" --location eastus2
}

function create_storage_account() {
    az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS
}

function get_storage_account_key() {
    ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)
}

function create_blob_container() {
    az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key "$ACCOUNT_KEY"
}

function main() {
    create_resource_group
    create_storage_account
    get_storage_account_key
    create_blob_container
}

main "$@"
