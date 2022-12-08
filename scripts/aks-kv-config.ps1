# Update AKS to enable AAD.
az aks enable-addons --addons azure-keyvault-secrets-provider --name $aksName --resource-group $rgName

az keyvault create -n aks-openhack-team3-kv -g teamResources

az keyvault secret set --vault-name aks-openhack-team3-kv -n Environment --value Development
az keyvault secret set --vault-name aks-openhack-team3-kv -n SqlServer --value sqlservernom9737.database.windows.net
az keyvault secret set --vault-name aks-openhack-team3-kv -n SqlName --value mydrivingDB
az keyvault secret set --vault-name aks-openhack-team3-kv -n SqlUser --value sqladminnOm9737
az keyvault secret set --vault-name aks-openhack-team3-kv -n SqlPassword --value Password123!

