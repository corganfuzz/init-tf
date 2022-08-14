#! /bin/bash

RESOURCE_GROUP_NAME="eastTwo"
STORAGE_ACCOUNT_NAME="tfxstate-acc"
CONTAINER_NAME="tfxstate-cont"

function create_resource_group() {
    az group create --name "$RESOURCE_GROUP_NAME" --location eastus2
}

function create_storage_account() {
    ACCOUNT_KEY=$(az storage account create --resource-group "$RESOURCE_GROUP_NAME" --name $STORAGE_ACCOUNT_NAME)
}

function create_blob_container() {
    az storage container create --name "$CONTAINER_NAME" --account-name "$STORAGE_ACCOUNT_NAME" --account-key "$ACCOUNT_KEY"
}

function main() {
    create_resource_group
    create_storage_account
    create_blob_container
}

main "$@"
