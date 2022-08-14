#!/bin/bash

@ This accepts the azure marketplace terms with Azure CLI for nginx plus vm image

az vm image list --all --publisher nginxinc --offer nginx-plus-v1 --sku nginx-plus-ubuntu1804 --query '[0].urn'
az vm image terms accept --urn nginxinc:nginx-plus-v1-standard:nginx-plus-ubuntu1804:4.0.1
