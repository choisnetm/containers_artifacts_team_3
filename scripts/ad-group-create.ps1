./az-login.ps1

az login --username  'hacker5shc@msftopenhack6950ops.onmicrosoft.com' --password '7%XhRhoE3n'

$aksName = 'openhack-aks-challenge3-bis'
$rgName = 'teamResources'
$webdevGroupName = 'web-dev'
$apidevGroupName = 'api-dev'
$webDevUser = 'webdev@msftopenhack6950ops.onmicrosoft.com'
$apiDevUser = 'apidev@msftopenhack6950ops.onmicrosoft.com'

Write-Host "Get AKS $rgName.$aksName ID"

$AKS_ID=$(az aks show `
    --resource-group $rgName `
    --name $aksName `
    --query id -o tsv)

Write-Host "AKS ID: $AKS_ID"


### GROUP CREATION
Write-Host "Create WEB DEV Group"

$WEBDEV_ID=$(az ad group create `
--display-name $webdevGroupName `
--mail-nickname webdev `
--query id `
-o tsv)

Write-Host "WEB DEV Group Id: $WEBDEV_ID"

Write-Host "Create API DEV Group"

$APIDEV_ID=$(az ad group create `
--display-name $apidevGroupName `
--mail-nickname apidev `
--query id `
-o tsv)

Write-Host "API DEV Group Id: $APIDEV_ID"

### GROUP ASSIGNATION TO K8s

Write-Host "Assign WEB DEV Group to AKS Role"
az role assignment create `
  --assignee $WEBDEV_ID `
  --role "Azure Kubernetes Service Cluster User Role" `
  --scope $AKS_ID

Write-Host "Assign API DEV Group to AKS Role"
az role assignment create `
  --assignee $APIDEV_ID `
  --role "Azure Kubernetes Service Cluster User Role" `
  --scope $AKS_ID

### USER ADD TO GROUPS

Write-Host "Add Web User to web-dev group"

$WebUserId=$(az ad user show --id $webDevUser --query id -o tsv)

az ad group member add `
    --group $WEBDEV_ID `
    --member-id $WebUserId 

Write-Host "Add Api User to api-dev group"

$ApiUserId=$(az ad user show --id $apiDevUser --query id -o tsv)

az ad group member add `
    --group $APIDEV_ID `
    --member-id $ApiUserId 