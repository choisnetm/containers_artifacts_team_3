./az-login.ps1

$acrName = 'registrynom9737'
$aksName = 'openhack-aks'
$rgName = 'teamResources'
$dockerRegistryServer = 'registrynom9737.azurecr.io'
$acrLogin = 'registrynom9737'
$acrPassword = 'ArwO+4WI1pBwTVOWCzdlrfOckT00o+9z'

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

# az aks update -n $aksName -g $rgName --attach-acr $acrName

#Retrieve aks credentials to run kubectl cmd
az aks get-credentials --resource-group $rgName --name $aksName

kubectl get nodes

# kubectl create secret docker-registry regcred `
# --docker-server=$dockerRegistryServer `
# --docker-username=$acrLogin `
# --docker-password=$acrPassword

#Deploy
kubectl apply -f ./namespaces-deploy.yaml
kubectl apply -f ./trips-deploy.yaml
kubectl apply -f ./user-java-deploy.yaml
kubectl apply -f ./users-profiles-deploy.yaml
kubectl apply -f ./poi-deploy.yaml


kubectl apply -f ./tripviewer-deploy.yaml

# POD Content
# $podname = (kubectl get pods -l app=wanesy -o json | ConvertFrom-Json).items[0].metadata.name
# kubectl describe pod $podname