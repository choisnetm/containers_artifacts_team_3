# Authenth.
./az-login.ps1

# Variables
$acrName = 'registrynom9737'
$aksName = 'openhack-aks-challenge3-bis'
$rgName = 'teamResources'

# Retrieve aks credentials to run kubectl cmd
az aks get-credentials --resource-group $rgName --name $aksName

# Update AKS to grant access to ACR.
az aks update -n $aksName -g $rgName --attach-acr $acrName

#Deploy namespaces
kubectl apply -f ./namespaces-deploy.yaml

# Create api secrets
./aks-secrets.ps1

# Deploy api namespace
kubectl apply -f ./trips-deploy.yaml
kubectl apply -f ./user-java-deploy.yaml
kubectl apply -f ./users-profiles-deploy.yaml
kubectl apply -f ./poi-deploy.yaml

# Deploy web namespace
kubectl apply -f ./tripviewer-deploy.yaml

# Deploy rbac role
kubectl apply -f ./k8s-rbac.yaml

# Deploy rolebindings
kubectl apply -f ./k8s-rolebinding.yaml

# Bing AKS roles to ADD groups
./ad-group-create.ps1
