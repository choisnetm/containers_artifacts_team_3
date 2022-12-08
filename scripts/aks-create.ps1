./az-login.ps1

$acrName = 'registrynom9737'
$aksName = 'openhack-aks'
$rgName = 'teamResources'
$dockerRegistryServer = 'registrynom9737.azurecr.io'
$acrLogin = 'registrynom9737'
$acrPassword = 'ArwO+4WI1pBwTVOWCzdlrfOckT00o+9z'
$vnetSubnetId = '/subscriptions/c56594cd-3b57-4a5b-9cea-eebd774fdddd/resourceGroups/teamResources/providers/Microsoft.Network/virtualNetworks/vnet/subnets/aks-subnet'
$admonGroupObjectIds = '09f565d5-d7ed-4bf8-b8c3-8fd22b80dc23'

# $aksExist = az aks show --name $aksName --resource-group $rgName

# # Create AKS
# az aks create `
# -g $rgName -n $aksName `
# --enable-managed-identity `
# --node-count 1 `
# --enable-addons monitoring `
# --enable-msi-auth-for-monitoring  `
# --generate-ssh-keys `
# --attach-acr $acrName

# az aks create `
# --resource-group $rgName `
# --name $aksName `
# --enable-managed-identity `
# --node-count 1 `
# --enable-addons monitoring `
# --enable-msi-auth-for-monitoring
# --network-plugin azure `
# --vnet-subnet-id $vnetSubnetId `
# --generate-ssh-keys `
# --docker-bridge-address 172.17.0.1/16 `
# --dns-service-ip 10.0.0.10 `
# --service-cidr 10.0.0.0/16 `
# --enable-private-cluster `
# --attach-acr $acrName `
# --aad-admin-group-object-ids $admonGroupObjectIds `
# --enable-aad

# az aks update -n $aksName -g $rgName --attach-acr $acrName

#Retrieve aks credentials to run kubectl cmd
az aks get-credentials --resource-group $rgName --name $aksName

kubectl get nodes

# kubectl create secret docker-registry regcred `
# --docker-server=$dockerRegistryServer `
# --docker-username=$acrLogin `
# --docker-password=$acrPassword

#Deploy
kubectl apply -f ./deployments/namespaces-deploy.yaml
# kubectl apply -f ./deployments/trips-deploy.yaml
# kubectl apply -f ./deployments/user-java-deploy.yaml
# kubectl apply -f ./deployments/users-profiles-deploy.yaml
# kubectl apply -f ./deployments/poi-deploy.yaml


# kubectl apply -f ./deployments/tripviewer-deploy.yaml

# POD Content
# $podname = (kubectl get pods -l app=wanesy -o json | ConvertFrom-Json).items[0].metadata.name
# kubectl describe pod $podname