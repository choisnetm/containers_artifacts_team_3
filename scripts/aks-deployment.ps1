# Authenth.
./az-login.ps1

# Variables
$acrName = 'registrynom9737'
$aksName = 'openhack-aks-challenge3-bis'
$rgName = 'teamResources'

# Retrieve aks credentials to run kubectl cmd
az aks get-credentials --resource-group teamResources --name openhack-aks-challenge3-bis

# Update AKS to grant access to ACR.
az aks update -n $aksName -g $rgName --attach-acr $acrName
# Update AKS to enable AAD.
az aks update -n $aksName -g $rgName --enable-aad

#Deploy namespaces
kubectl apply -f ./deployments/namespaces-deploy.yaml


# Create api secrets
./aks-secrets.ps1

# Deploy api namespace
kubectl apply -f ./deployments/trips-deploy.yaml
kubectl apply -f ./deployments/user-java-deploy.yaml
kubectl apply -f ./deployments/users-profiles-deploy.yaml
kubectl apply -f ./deployments/poi-deploy.yaml

# Deploy web namespace
kubectl apply -f ./deployments/tripviewer-deploy.yaml

# Deploy rbac role
kubectl apply -f ./deployments/k8s-rbac.yaml

# Deploy rolebindings
kubectl apply -f ./deployments/k8s-rolebinding.yaml

# Bing AKS roles to ADD groups
./ad-group-create.ps1
